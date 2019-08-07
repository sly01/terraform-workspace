data "aws_ami" "ubuntu_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server*"]
  }
}

resource "aws_launch_configuration" "asg_launch_conf" {
  image_id        = "${data.aws_ami.ubuntu_ami.id}"
  instance_type   = "${var.instance_type}"
  security_groups = ["${aws_security_group.sg_web.id}"]

  user_data = <<-EOF
  #!/bin/bash
  echo "Hello, this service is provided from ${var.region}-${var.environment}" > index.html
  nohup busybox httpd -f -p "${var.web_port}" &
  EOF

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_availability_zones" "all" {
}

resource "aws_autoscaling_group" "das_asg" {
  launch_configuration = "${aws_launch_configuration.asg_launch_conf.id}"
  availability_zones = "${data.aws_availability_zones.all.names}"

  load_balancers = ["${aws_elb.elb.name}"]
  health_check_type = "ELB"

  tag {
    key = "Name"
    value = "terraform-asg-example"
    propagate_at_launch = true
  }
  max_size = "${var.max_size}"
  min_size = "${var.min_size}"
}
