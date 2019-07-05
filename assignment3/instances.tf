resource "aws_instance" "server1" {
  #ami = "ami-0c6b1d09930fac512"
  ami = "${data.aws_ami.latest-amazon-linux2.id}"
  #instance_type = "t2.micro"
  instance_type = "${var.instance_flavor}"

  tags = {
    Name = "server1"
  }
}
