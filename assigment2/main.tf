provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "atos-vpc" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_internet_gateway" "atos-igw" {
  vpc_id = "${aws_vpc.atos-vpc.id}"
}

resource "aws_subnet" "public1" {
  cidr_block              = "172.16.1.0/24"
  vpc_id                  = "${aws_vpc.atos-vpc.id}"
  map_public_ip_on_launch = true
}

resource "aws_route_table" "RT" {
  vpc_id = "${aws_vpc.atos-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.atos-igw.id}"
  }
}

resource "aws_route_table_association" "RT-association" {
  route_table_id = "${aws_route_table.RT.id}"
  subnet_id      = "${aws_subnet.public1.id}"
}

resource "aws_security_group" "SG" {
  name        = "public-sg"
  description = "allow all internet"
  vpc_id      = "${aws_vpc.atos-vpc.id}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
}

data "aws_ami" "latest-amazon-linux2" {
  most_recent = true
  owners      = ["137112412989"] # Amazon

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "server1" {
  #ami                   = "ami-0c6b1d09930fac512"
  ami                    = "${data.aws_ami.latest-amazon-linux2.id}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.public1.id}"
  vpc_security_group_ids = ["${aws_security_group.SG.id}"]

  tags = {
    Name = "server1"
  }
}
