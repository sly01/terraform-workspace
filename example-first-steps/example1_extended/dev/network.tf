resource "aws_security_group" "web-sg" {
  name        = "webserver-sg-asdfasdf"
  description = "Adam request ${var.sg_description}"

  ingress {
    from_port   = var.web_port
    to_port     = var.web_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web-ssh" {
  name        = "web-ssh"
  description = "we are having fun with atos dudes in sanok, 8080 port"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "sg_elb" {
  name        = "sg_elb"
  description = "security group for elb"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
data "aws_availability_zones" "all" {}

resource "aws_elb" "example_elb" {
  name               = "terraform-atos-elb"
  security_groups    = [aws_security_group.sg_elb.id]
  availability_zones = data.aws_availability_zones.all.names
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

#--------- ROUTE53 --------

resource "aws_route53_zone" "primary" {
  name              = "${var.domain_name}.tk"
  delegation_set_id = "${var.delegation_set}"
}

resource "aws_route53_record" "dev" {
  name    = "dev.${var.domain_name}.tk"
  type    = "A"
  zone_id = "${aws_route53_zone.primary.id}"

  alias {
    name                   = "${aws_elb.example_elb.dns_name}"
    zone_id                = "${aws_elb.example_elb.zone_id}"
    evaluate_target_health = false
  }
}
