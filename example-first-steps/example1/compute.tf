resource "aws_instance" "web" {
  ami           = "ami-026c8acd92718196b"
  instance_type = "t2.micro"
  key_name      = "aws-eb"
  #vpc_security_group_ids = ["${aws_security_group.web-sg.id}", aws_security_group.web-ssh.id]
  vpc_security_group_ids = [aws_security_group.web-sg.id, aws_security_group.web-ssh.id]
  user_data              = <<-EOF
  #!/bin/bash
  echo "Hello, my name is sly" > index.html
  nohup busybox httpd -f -p "${var.web_port}" &
  EOF
  tags = {
    Name = "web-server"
  }
}
