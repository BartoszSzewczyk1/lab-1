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