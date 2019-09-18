output "public_dns" {
  value = "${aws_instance.server.*.public_dns}"
}

output "public_ip" {
  value = "${aws_instance.server.*.public_ip}"
}
