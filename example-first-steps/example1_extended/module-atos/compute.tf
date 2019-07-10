data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
resource "aws_launch_configuration" "asg_launch_conf" {
  image_id        = "${data.aws_ami.ubuntu.id}"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.web-sg.id}"]

  user_data = <<-EOF
  #!/bin/bash
  echo "Hello, my name is sly, this service is provided from ${var.region}" > index.html
  nohup busybox httpd -f -p "${var.web_port}" &
  EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg-atos" {
  launch_configuration = "${aws_launch_configuration.asg_launch_conf.id}"
  availability_zones = "${data.aws_availability_zones.all.names}"
  max_size = 10
  min_size = 3

  load_balancers = ["${aws_elb.example_elb.name}"]
  health_check_type = "ELB"

  tag {
    key = "Name"
    value = "terraform-asg-example"
    propagate_at_launch = true
  }
}
