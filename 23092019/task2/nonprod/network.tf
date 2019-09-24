resource "aws_security_group" "allow_http" {
  name        = "sg_web"
  description = "created for http traffic"

  ingress {
    # TLS (change to whatever ports you need)
    from_port = "${var.web_port}"
    to_port   = "${var.web_port}"
    protocol  = "TCP"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

}
