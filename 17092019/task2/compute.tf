resource "aws_instance" "server" {
  ami           = data.aws_ami.uptoyou.id
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}
