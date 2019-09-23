resource "aws_instance" "uptoyou" {
  # number of instances
  #count = 5
  #ami          = "ami-0ac05733838eabc06"
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  user_data     = <<-EOF
  #!/bin/bash
  echo "Hello from Atos Bydgoszcz" > index.html
  sudo nohup busybox httpd -f -p 80 &
  EOF

  vpc_security_group_ids = [aws_security_group.allow_http.id]

  tags = {
    "Name" = "created by terraform updated"
  }
}
