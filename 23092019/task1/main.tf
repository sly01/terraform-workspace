provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

output "lotsofstuff" {
  value = data.aws_ami.ubuntu.*
}

resource "aws_instance" "uptoyou" {
  # number of instances
  #count = 5
  #ami           = "ami-0ac05733838eabc06"
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  tags = {
    "Name" = "created by terraform updated"
  }
}
