provider "aws" {
  region = "us-east-1"
}

variable "instance_count" {
  default = 2
}

resource "aws_instance" "server" {
  count         = "${var.instance_count}"
  ami           = "ami-0c6b1d09930fac512"
  instance_type = "${lookup(var.instance_type, var.env)}"

  tags = {
    Name = "server-${var.env}"
  }
}
