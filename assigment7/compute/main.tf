resource "aws_elb" "elb-web" {
  name = "demo-elb"

  subnets         = ["${var.public_subnets}"]
  security_groups = ["${var.elb-sg}"]
  instances       = ["${aws_instance.web.*.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = "2"
    unhealthy_threshold = "2"
    timeout             = "3"
    target              = "TCP:80"
    interval            = "30"
  }
}

resource "aws_instance" "web" {
  count                  = "${var.instance-count}"
  ami                    = "ami-0f8969098ad3dfd44"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${var.instance-sg}"]
  subnet_id              = "${var.private_subnets[count.index]}"
}
