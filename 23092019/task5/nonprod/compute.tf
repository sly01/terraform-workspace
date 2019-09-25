resource "aws_launch_configuration" "my_launch_config" {
  image_id        = data.aws_ami.ubuntu.id
  instance_type   = "${var.instance_type}"
  security_groups = ["${aws_security_group.allow_http.id}"]

  user_data = <<-EOF
  #!/bin/bash
  echo "<h1 align='center'>Hello from Atos Bydgoszcz ${var.region} - ${var.env}</h1>" > index.html
  curl http://169.254.169.254/latest/meta-data/instance-id >> index.html
  sudo nohup busybox httpd -f -p "${var.web_port}" &
  EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "my_asg" {
  launch_configuration = "${aws_launch_configuration.my_launch_config.id}"
  availability_zones = "${data.aws_availability_zones.all.names}"
  max_size = "${var.max_size}"
  min_size = "${var.min_size}"
  load_balancers = ["${aws_elb.elb.name}"]
  health_check_type = "ELB"
  tag {
    key = "Name"
    value = "atos-asg-test"
    propagate_at_launch = true
  }
}
