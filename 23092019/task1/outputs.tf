output "public_dns" {
  value = aws_instance.uptoyou.*.public_dns
}
output "instance_ip" {
  value = aws_instance.uptoyou.*.public_ip
}
