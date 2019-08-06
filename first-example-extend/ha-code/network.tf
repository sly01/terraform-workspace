resource "aws_security_group" "sg_web" {
  name        = "Web security group ${var.environment}"
  description = "Ubuntu test web server ${var.web_port} port ${var.environment}"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = var.web_port
    to_port     = var.web_port
    protocol    = "TCP"
  }
}

resource "aws_security_group" "sg_elb" {
  name        = "Elb security group ${var.environment}"
  description = "Elb security group desc ${var.web_port} port ${var.environment}"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
}

data "aws_availability_zones" "all" {}

resource "aws_elb" "elb" {
  name               = "atos-elb"
  security_groups    = ["${aws_security_group.sg_elb.id}"]
  availability_zones = data.aws_availability_zones.all.names
  instances          = aws_instance.ubuntu-server.*.id
  health_check {
    target              = "HTTP:${var.web_port}/"
    interval            = 10
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  listener {
    instance_port     = "${var.web_port}"
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}
