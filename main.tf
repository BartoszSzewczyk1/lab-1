provider "aws" {
  # Configuration options
  ignore_tags {
    keys = var.tags-to-ignore
  }
}

resource "aws_s3_bucket" "my-bucket" {
  bucket_prefix = "awsninja12-"
}

resource "aws_s3_object" "object" {
  for_each = fileset(path.module, "messages/*")

  bucket = aws_s3_bucket.my-bucket.bucket
  key    = basename(each.key)
  source = each.key
}


# INPUT
# cidr ="10.0.0.0/16" (string)
# public_ip_on_launch = true|false (bool)
# subnets = ["10.0.1.0/24", "10.0.2.0/24"] # subnety prywatne

# tags

# output
# vpc_id

resource "aws_vpc" "my-vpc" {
  cidr_block = var.cidr

  tags = merge(
    {
      name = "my-vpc"
    },
    var.tags
  )
}

resource "aws_subnet" "private" {
  for_each = toset(var.subnets)

  vpc_id = aws_vpc.my-vpc.id
  cidr_block = each.key
  map_public_ip_on_launch = var.public_ip_on_launch

  tags = merge(
    {
      name = "private-${replace(each.key, "/", "-")}"
      type = "private"
    },
    var.tags
  )
}