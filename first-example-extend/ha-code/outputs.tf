output "public_dns" {
  value = aws_instance.ubuntu-server.*.public_dns
}
output "public_ip" {
  value = aws_instance.ubuntu-server.*.public_ip
}

output "elb_dns" {
  value = aws_elb.elb.dns_name
}
