provider "aws" {
  region = "us-east-1"
}

variable "ami_id" {}

variable "instance_count" {
  default = 2
}

resource "aws_instance" "server" {
  count         = "${var.instance_count}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"

  tags = {
    Name = "server${count.index+1}"
  }
}
