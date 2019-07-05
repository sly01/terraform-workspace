resource "aws_instance" "web3" {
  ami                    = "ami-0ea75b87734858a94"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.elb-to-ec2.id}"]
  subnet_id              = "${aws_subnet.private1.id}"
}
