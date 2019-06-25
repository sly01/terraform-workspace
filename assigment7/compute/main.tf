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
    healthy_threshold   = "${var.elb_healthy_threshold}"
    unhealthy_threshold = "${var.elb_unhealthy_threshold}"
    timeout             = "3"
    target              = "TCP:80"
    interval            = "30"
  }
}

resource "aws_key_pair" "demo-key" {
  key_name   = "demo-key"
  public_key = "${var.public_key}"
}

resource "aws_instance" "web" {
  count                  = "${var.instance-count}"
  ami                    = "ami-0f8969098ad3dfd44"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${var.instance-sg}", "${var.ansible-management-sg}"]
  subnet_id              = "${var.private_subnets[count.index]}"
  key_name               = "${aws_key_pair.demo-key.id}"
}
