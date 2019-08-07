resource "aws_security_group" "sg_web" {
  name        = "sg_web_${var.environment}"
  description = "Web security group"

  ingress {
    from_port   = "${var.web_port}"
    to_port     = "${var.web_port}"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_elb" {
  name        = "sg_elb_${var.environment}"
  description = "ELB Security Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "elb" {
  name               = "Terraform-elb-${var.environment}"
  security_groups    = ["${aws_security_group.sg_elb.id}"]
  availability_zones = "${data.aws_availability_zones.all.names}"
  health_check {
    target              = "HTTP:${var.web_port}/"
    interval            = 30
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
