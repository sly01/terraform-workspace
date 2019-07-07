# Create a random id
resource "random_id" "tf_bucket_id" {
  byte_length = 2
}

# Create the bucket
resource "aws_s3_bucket" "tf_code" {
    bucket        = format("%s-%d", var.project_name, random_id.tf_bucket_id.dec)
    acl           = "private"
    force_destroy =  true
    tags          = {
      Name = "tf_bucket"
    }
  }
