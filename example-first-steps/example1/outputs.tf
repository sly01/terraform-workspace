output "public_dns_name_of_my_machine" {
  value = aws_instance.web.public_dns
}

output "public_ip_of_my_machine" {
  value = aws_instance.web.public_ip
}

output "my_machine" {
  value = format("Public ip - %s\nPublic dns - %s", aws_instance.web.public_ip, aws_instance.web.public_dns)
}
