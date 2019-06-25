resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr}"
  tags = {
      Name = "test-vpc"
  }
}

data "aws_availability_zones" "available" {
  
}

resource "aws_internet_gateway" "igw" {
  tags = {
      Name = "test-igw"
  }
}

resource "aws_route_table" "public-RT" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.igw.id}"
  }
}

resource "aws_subnet" "public" {
  count = "${length(var.public_subnets)}"
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.public_subnets[count.index]}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = true
  tags = {
      Name= "public_subnet_${count.index+1}"
  }
}

resource "aws_route_table_association" "public_assoc" {
  count = "${length(var.public_subnets)}"
  route_table_id = "${aws_route_table.public-RT}"
  subnet_id = "${aws_subnet.public.*.id[count.index]}"
}

resource "aws_security_group" "alltraffic-sg" {
  name = "alltraffic-sg"
  description = "Allowing all traffic ingree and egress"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}