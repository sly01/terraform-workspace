provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "server" {
  ami           = "ami-0cdab515472ca0bac"
  instance_type = "t2.micro"

  tags = {
    Name = "test-server"
  }
}
