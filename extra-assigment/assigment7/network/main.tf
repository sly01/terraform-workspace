data "aws_availability_zones" "available" {}

resource "aws_vpc" "demovpc" {
  cidr_block = "${var.cidr_block}"

  tags = {
    Name = "demovpc"
  }
}

resource "aws_internet_gateway" "demoigw" {
  vpc_id = "${aws_vpc.demovpc.id}"

  tags = {
    Name = "demoigw"
  }
}

resource "aws_subnet" "private_subnet" {
  count                   = "${var.private_subnet_count}"
  cidr_block              = "${var.private_cidrs[count.index]}"
  vpc_id                  = "${aws_vpc.demovpc.id}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"

  tags = {
    Name = "private_subnet${count.index+1}"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = "${var.public_subnet_count}"
  cidr_block              = "${var.public_cidrs[count.index]}"
  vpc_id                  = "${aws_vpc.demovpc.id}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"

  tags = {
    Name = "public_subnet${count.index+1}"
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

resource "aws_route_table_association" "private_assoc" {
  count          = "${var.private_subnet_count}"
  route_table_id = "${aws_default_route_table.private-RT.id}"
  subnet_id      = "${aws_subnet.private_subnet.*.id[count.index]}"
}

resource "aws_route_table_association" "public_assoc" {
  count          = "${var.public_subnet_count}"
  route_table_id = "${aws_route_table.public-RT.id}"
  subnet_id      = "${aws_subnet.public_subnet.*.id[count.index]}"
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

resource "aws_security_group" "ansible-management-sg" {
  name        = "ansible-management-sg"
  description = "Ansible controller node allowed from other vpc"
  vpc_id      = "${aws_vpc.demovpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
