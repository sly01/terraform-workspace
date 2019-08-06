resource "aws_security_group" "sg_web" {
  name        = "Web security group ${var.environment}"
  description = "Ubuntu test web server ${var.web_port} port ${var.environment}"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = var.web_port
    to_port     = var.web_port
    protocol    = "TCP"
  }
}
