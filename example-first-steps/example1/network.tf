resource "aws_security_group" "web-sg" {
  name        = "webserver-sg-asdfasdf"
  description = "Adam request ${var.sg_description}"

  ingress {
    from_port   = var.web_port
    to_port     = var.web_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web-ssh" {
  name        = "web-ssh"
  description = "we are having fun with atos dudes in sanok, 8080 port"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
