resource "aws_security_group" "sg_web" {
  name        = "sg_web"
  description = "for custom web"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "${var.web_port}"
    to_port     = "${var.web_port}"
    protocol    = "TCP"
  }
}

resource "aws_security_group" "sg_elb" {
  name        = "sg_elb"
  description = "security group for elb"
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

data "aws_availability_zones" "all" {

}

resource "aws_elb" "elb" {
  name            = "Atos-elb"
  security_groups = ["${aws_security_group.sg_elb.id}"]
  # Bugy 's' implementation expect []
  availability_zones = "${data.aws_availability_zones.all.names}"
  health_check {
    target              = "HTTP:${var.web_port}/"
    interval            = 20
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

