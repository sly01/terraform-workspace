resource "aws_security_group" "web-sg" {
  name        = "webserver-sg-asdfasdf"
  description = "Adam request ${var.sg_description}"

  ingress {
    from_port   = "${var.web_port}"
    to_port     = "${var.web_port}"
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

#--------- ROUTE53 --------

data "aws_route53_zone" "dns_zone" {
  count = "${var.dns_zone_creation ? 0 : 1}"
  name  = "${var.domain_name}.tk."
}

resource "aws_route53_zone" "primary" {
  count             = "${var.dns_zone_creation ? 1 : 0}"
  name              = "${var.domain_name}.tk"
  delegation_set_id = "${var.delegation_set}"
}

resource "aws_route53_record" "subdomain" {
  name    = "${var.environment}.${var.domain_name}.tk"
  type    = "A"
  zone_id = "${var.dns_zone_creation ? aws_route53_zone.primary.*.id[0] : data.aws_route53_zone.dns_zone.*.id[0]}"

  alias {
    name                   = "${aws_elb.example_elb.dns_name}"
    zone_id                = "${aws_elb.example_elb.zone_id}"
    evaluate_target_health = false
  }
}
