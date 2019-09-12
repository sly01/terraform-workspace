resource "aws_security_group" "sg_web" {
  name        = "sg_web"
  description = "for custom web"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "${var.web_port}"
    to_port     = "${var.web_port}"
    protocol    = "TCP"
  }
}
