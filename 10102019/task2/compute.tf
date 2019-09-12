resource "aws_instance" "web" {
  ami                    = "${data.aws_ami.ubuntuimage.id}"
  instance_type          = var.instance_type
  vpc_security_group_ids = ["${aws_security_group.sg_web.id}"]
  user_data              = <<-EOF
  #!/bin/bash
  echo "Hello from Atos Bydgoszcz" > index.html
  sudo nohup busybox httpd -f -p "${var.web_port}" &
  EOF

  tags = {
    Name = "${var.env}-ubuntu-web-server"
  }
}
