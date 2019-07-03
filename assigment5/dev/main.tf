provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "server" {
  ami           = "ami-0c6b1d09930fac512"
  instance_type = "t2.micro"

  tags = {
    Name = "server-${var.env}"
  }
}
