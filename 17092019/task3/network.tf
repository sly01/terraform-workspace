resource "aws_security_group" "allow_web" {
  name        = "sg_web"
  description = "Allow web traffic"

  ingress {
    from_port = "${var.web_port}"
    to_port   = "${var.web_port}"
    protocol  = "TCP"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
