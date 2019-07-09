output "public_dns_name_of_my_machine" {
  value = aws_instance.web.*.public_dns
}

output "public_ip_of_my_machine" {
  value = aws_instance.web.*.public_ip
}

output "elb_public_dns_name" {
  value = aws_elb.example_elb.dns_name
}
