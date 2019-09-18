resource "aws_instance" "server" {
  count                  = "${var.instance_count}"
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "${var.instance_size}"
  vpc_security_group_ids = ["${aws_security_group.allow_web.id}"]
  user_data              = <<-EOF
  #!/bin/bash
  echo "<h1><font color="red">Hello from Atos Bydgoszcz</font></h1>" > index.html
  curl http://169.254.169.254/latest/meta-data/instance-id >> index.html
  echo "${var.region} - ${var.env}" >> index.html
  sudo nohup busybox httpd -f -p "${var.web_port}" &
  EOF
  tags = {
    Name = "${var.env}-web_server-${count.index + 1}"
  }
}
