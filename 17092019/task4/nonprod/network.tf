resource "aws_security_group" "allow_web" {
  name        = "sg_web"
  description = "Allow web traffic"

  ingress {
    from_port = "${var.web_port}"
    to_port   = "${var.web_port}"
    protocol  = "TCP"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_elb" {
  name        = "sg_elb"
  description = "security group for elb"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "TCP"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_availability_zones" "all" {

}

resource "aws_elb" "elb" {
  name               = "my-elb"
  security_groups    = [aws_security_group.sg_elb.id]
  instances          = aws_instance.server.*.id
  availability_zones = data.aws_availability_zones.all.names
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
