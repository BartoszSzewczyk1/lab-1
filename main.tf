terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.25.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

resource "aws_s3_bucket" "my-bucket" {
  bucket_prefix = "awsninja-1-12-"
}

output "bucket_name" {
  value = aws_s3_bucket.my-bucket.bucket
}

resource "aws_s3_object" "object" {
  for_each = fileset(path.module, "messages/*")

  bucket = aws_s3_bucket.my-bucket.bucket
  key    = basename(each.key)
  source = each.key
}

# Input - Bucket prefix jako zmienna + jako domyslny jest ustawiony Twoj
# Input - Tagi, gdzie domyslne jest w variable "purpouse": "learning" (moze byc nadpisany)
# Zawsze dodawany tag do bucketu (lub wszedzie) "owner": "jw"
# Outputs: bucket ARN oraz pełny URL z HTTP

variable "bucket_prefix" {
  type = string
  default = "awsninja-1-12"
}

resource "random_string" "sufix" {
  length  = 12
  special = false
  upper   = false
  number  = true  
}

variable "purpose" {
  type = string
  default = "learning"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_prefix}-${random_string.sufix.result}"

  tags = {
    purpouse = var.purpose
    owner = "awsninja-1-12"
  }
}

output "bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}

output "bucket_URL" {
  value = "https://${aws_s3_bucket.bucket.bucket}.s3.amazonaws.com"
}