resource "aws_instance" "web" {
  count         = var.instance_count
  ami           = "ami-009c174642dba28e4"
  instance_type = "t2.micro"
  #vpc_security_group_ids = ["${aws_security_group.web-sg.id}", aws_security_group.web-ssh.id]
  vpc_security_group_ids = [aws_security_group.web-sg.id, aws_security_group.web-ssh.id]
  user_data              = <<-EOF
  #!/bin/bash
  echo "Hello, my name is sly" > index.html
  nohup busybox httpd -f -p "${var.web_port}" &
  EOF
  tags = {
    Name = "web-server-${count.index + 1}"
  }
}
