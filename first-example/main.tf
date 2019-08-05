provider "aws" {
  region = var.region
}
variable "region" {
  description = "Region information"
}

variable "instance_type" {
}

variable "web_port" {

}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server*"]
  }
}

resource "aws_instance" "ubuntu-server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg_web.id]
  user_data              = <<-EOF
  #!/bin/bash
  echo "Hello from Atos Bydgoszcz" > index.html
  nohup busybox httpd -f -p "${var.web_port}" &
  EOF
}

resource "aws_security_group" "sg_web" {
  name = "Web security group"
  description = "Ubuntu test web server ${var.web_port} port"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = var.web_port
    to_port = var.web_port
    protocol = "TCP"
  }
}

output "public_dns" {
  value = aws_instance.ubuntu-server.public_dns
}
output "public_ip" {
  value = aws_instance.ubuntu-server.public_ip
}
