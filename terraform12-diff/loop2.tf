variable "vpc_cidr" {
  default = "10.123.0.0/16"
}

variable "accessip" {
  default = "0.0.0.0/0"
}

variable "service_ports" {
  default = [
    {
      from_port = "22",
      to_port   = "22"
    },
    {
      from_port = "80",
      to_port   = "80"
    }
  ]
}

resource "aws_vpc" "tf_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tf_vpc"
  }
}

resource "aws_security_group" "tf_public_sg" {
  name        = "tf_public_sg"
  description = "Used for access to the public instances"
  vpc_id      = aws_vpc.tf_vpc.id

  dynamic "ingress" {
    for_each = [ for s in var.service_ports: {
      from_port = s.from_port
      to_port = s.to_port
    }]

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = "tcp"
      cidr_blocks = [var.accessip]
    }
  }
}

output "ingress_port_mapping" {
  value = {
    for ingress in aws_security_group.tf_public_sg.ingress:
    format("From %d", ingress.from_port) => format("To %d", ingress.to_port)
  }
}
