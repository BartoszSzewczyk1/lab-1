output "bucket_name" {
  value = aws_s3_bucket.my-bucket.bucket
}

# homework 3

output "vpc_id" {
  value = aws_vpc.my-vpc.id
}

output "private_subnet_id" {
  value = values(aws_subnet.private)[*].id
}