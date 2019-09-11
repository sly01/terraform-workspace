provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server*"]
  }
}

output "ubuntu_ami_id" {
  value = data.aws_ami.ubuntu.id
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  user_data     = <<-EOF
  #!/bin/bash
  echo "Hello world" > index.html
  sudo busybox httpd -f -p 80
  EOF

  vpc_security_group_ids = [aws_security_group.http_allow.id]
  tags = {
    Name = "web-server"
  }
}

output "server_ip" {
  value = aws_instance.server.public_ip
}


resource "aws_security_group" "http_allow" {
  description = "Allow http traffic"
  name = "sg_http"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    to_port = 80
    protocol = "TCP"
  }
}
