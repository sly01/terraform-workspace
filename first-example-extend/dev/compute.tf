data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server*"]
  }
}

resource "aws_instance" "ubuntu-server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg_web.id]
  user_data              = <<-EOF
  #!/bin/bash
  echo "Hello from Atos Bydgoszcz --- ${var.environment}" > index.html
  nohup busybox httpd -f -p "${var.web_port}" &
  EOF
}
