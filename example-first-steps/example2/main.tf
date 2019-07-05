provider "aws" {
  region = "us-east-1"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "public_subnets" {
  type    = "list"
  default = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
}

resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr}"
  tags = {
    Name = "test-vpc"
  }
}

data "aws_availability_zones" "available" {
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
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
  count                   = "${length(var.public_subnets)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.public_subnets[count.index]}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_${count.index + 1}"
  }
}

resource "aws_route_table_association" "public_assoc" {
  count          = "${length(var.public_subnets)}"
  route_table_id = "${aws_route_table.public-RT.id}"
  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
}

resource "aws_security_group" "alltraffic-sg" {
  name        = "alltraffic-sg"
  description = "Allowing all traffic ingree and egress"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "instance" {
  count                  = "${length(var.public_subnets)}"
  ami                    = "ami-0cd855c8009cb26ef"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.public.*.id[count.index]}"
  vpc_security_group_ids = ["${aws_security_group.alltraffic-sg.id}"]
}
