provider "aws" {
  region = "us-east-1"
}

# Create security group for postgreslq

data "aws_vpc" "defaultvpc" {
  default = true
}

resource "aws_security_group" "postgres_sg" {
  name        = "postgres-sg"
  description = "Postgresql security group port 5432 is allowed"
  vpc_id      = "${data.aws_vpc.defaultvpc.id}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "5432"
    to_port     = "5432"
    protocol    = "tcp"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
  }
}

resource "aws_db_instance" "postgres" {
  identifier             = "testdb"
  instance_class         = "db.t2.micro"
  engine                 = "${var.dbengine}"
  engine_version         = "${var.dbengine_version}"
  name                   = "${var.dbname}"
  username               = "${var.dbusername}"
  password               = "${var.dbpassword}"
  allocated_storage      = "10"
  publicly_accessible    = true
  skip_final_snapshot    = true
  vpc_security_group_ids = ["${aws_security_group.postgres_sg.id}"]
}

output "database_connection_endpoint" {
  value = "${aws_db_instance.postgres.endpoint}"
}
