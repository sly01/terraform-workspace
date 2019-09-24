resource "aws_security_group" "allow_http" {
  name        = "sg_web"
  description = "created for http traffic"

  ingress {
    # TLS (change to whatever ports you need)
    from_port = "${var.web_port}"
    to_port   = "${var.web_port}"
    protocol  = "TCP"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_availability_zones" "all" {

}


resource "aws_elb" "elb" {
  name               = "my-elb"
  availability_zones = "${data.aws_availability_zones.all.names}"
  security_groups    = ["${aws_security_group.sg_elb.id}"]
  instances          = aws_instance.uptoyou.*.id
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:${var.web_port}/"
    interval            = 20
  }

  listener {
    instance_port     = "${var.web_port}"
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}

resource "aws_security_group" "sg_elb" {
  name        = "sg_elb"
  description = "created for http load balancer(elb)"

  ingress {
    # TLS (change to whatever ports you need)
    from_port = 80
    to_port   = 80
    protocol  = "TCP"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    # TLS (change to whatever ports you need)
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }
}

