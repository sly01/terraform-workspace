output "instance_public_dns" {
  value = "${aws_instance.server.public_dns}"
}
