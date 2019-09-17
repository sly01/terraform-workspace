provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "server" {
  ami           = "ami-0ac05733838eabc06"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}
