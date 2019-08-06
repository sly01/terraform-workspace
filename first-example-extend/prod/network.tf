resource "aws_security_group" "sg_web" {
  name        = "Web security group"
  description = "Ubuntu test web server ${var.web_port} port"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = var.web_port
    to_port     = var.web_port
    protocol    = "TCP"
  }
}
