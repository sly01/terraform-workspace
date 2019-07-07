output "bucketname" {
  value = aws_s3_bucket.tf_code.id
}

output "project_name" {
  value = var.project_name
}
