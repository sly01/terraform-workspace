provider "aws" {
  region = "eu-central-1"
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "demovpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "demovpc"
  }
}

resource "aws_internet_gateway" "demoigw" {
  vpc_id = "${aws_vpc.demovpc.id}"

  tags {
    Name = "demoigw"
  }
}

resource "aws_subnet" "private1" {
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = "${aws_vpc.demovpc.id}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags = {
    Name = "subnet-private1"
  }
}

resource "aws_subnet" "private2" {
  cidr_block              = "10.0.2.0/24"
  vpc_id                  = "${aws_vpc.demovpc.id}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"

  tags = {
    Name = "subnet-private2"
  }
}

resource "aws_subnet" "public3" {
  cidr_block              = "10.0.3.0/24"
  vpc_id                  = "${aws_vpc.demovpc.id}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags = {
    Name = "subnet-public3"
  }
}

resource "aws_subnet" "public4" {
  cidr_block              = "10.0.4.0/24"
  vpc_id                  = "${aws_vpc.demovpc.id}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"

  tags = {
    Name = "subnet-public4"
  }
}

resource "aws_route_table" "public-RT" {
  vpc_id = "${aws_vpc.demovpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.demoigw.id}"
  }
}

resource "aws_default_route_table" "private-RT" {
  default_route_table_id = "${aws_vpc.demovpc.default_route_table_id}"
}

resource "aws_route_table_association" "private1_assoc" {
  route_table_id = "${aws_default_route_table.private-RT.id}"
  subnet_id      = "${aws_subnet.private1.id}"
}

resource "aws_route_table_association" "private2_assoc" {
  route_table_id = "${aws_default_route_table.private-RT.id}"
  subnet_id      = "${aws_subnet.private2.id}"
}

resource "aws_route_table_association" "public3_assoc" {
  route_table_id = "${aws_route_table.public-RT.id}"
  subnet_id      = "${aws_subnet.public3.id}"
}

resource "aws_route_table_association" "public4_assoc" {
  route_table_id = "${aws_route_table.public-RT.id}"
  subnet_id      = "${aws_subnet.public4.id}"
}

resource "aws_security_group" "elb-sg" {
  name        = "elb-sg"
  description = "elb security group"
  vpc_id      = "${aws_vpc.demovpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "elb-to-ec2" {
  name        = "ebl-to-ec2"
  description = "Sg group between ec2 and elb"
  vpc_id      = "${aws_vpc.demovpc.id}"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.elb-sg.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "elb-web" {
  name = "demo-elb"

  subnets         = ["${aws_subnet.public3.id}", "${aws_subnet.public4.id}"]
  security_groups = ["${aws_security_group.elb-sg.id}"]
  instances       = ["${aws_instance.web1.id}", "${aws_instance.web2.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = "2"
    unhealthy_threshold = "2"
    timeout             = "3"
    target              = "TCP:80"
    interval            = "30"
  }
}

resource "aws_instance" "web1" {
  ami                    = "ami-0ea75b87734858a94"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.elb-to-ec2.id}"]
  subnet_id              = "${aws_subnet.private1.id}"
}

resource "aws_instance" "web2" {
  ami           = "ami-0ea75b87734858a94"
  instance_type = "t2.micro"

  vpc_security_group_ids = ["${aws_security_group.elb-to-ec2.id}"]
  subnet_id              = "${aws_subnet.private2.id}"
}

output "elb-endpoint" {
  value = "${aws_elb.elb-web.dns_name}"
}
