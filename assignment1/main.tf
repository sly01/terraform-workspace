provider "aws" {
  region = "us-east-1"
}

variable "instance_flavor" {
  default     = "t2.micro"
  description = "Size of instance"
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
  #ami = "ami-0c6b1d09930fac512"
  ami = "${data.aws_ami.latest-amazon-linux2.id}"
  #instance_type = "t2.micro"
  instance_type = "${var.instance_flavor}"

  tags = {
    Name = "server1"
  }
}

output "server1_public_hostname" {
  value = "${aws_instance.server1.public_dns}"
}
