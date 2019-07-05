resource "aws_instance" "instance" {
  count = "${length(var.public_subnets)}"
  ami = "ami-0cd855c8009cb26ef"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public.*.id[count.index]}"
  vpc_security_group_ids = ["${aws_security_group.alltraffic-sg.id}"]
}
