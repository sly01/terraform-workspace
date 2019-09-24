resource "aws_instance" "uptoyou" {
  # number of instances
  count = "${var.instance_count}"
  #ami          = "ami-0ac05733838eabc06"
  ami           = data.aws_ami.ubuntu.id
  instance_type = "${var.instance_type}"
  user_data     = <<-EOF
  #!/bin/bash
  echo "<h1 align='center'>Hello from Atos Bydgoszcz ${var.region} - ${var.env}</h1>" > index.html
  curl http://169.254.169.254/latest/meta-data/instance-id >> index.html
  sudo nohup busybox httpd -f -p "${var.web_port}" &
  EOF

  vpc_security_group_ids = [aws_security_group.allow_http.id]

  tags = {
    "Name" = "${var.env} - created by terraform"
  }
}
