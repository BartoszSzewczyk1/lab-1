terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.25.0"
    }
  }
  backend "s3" {
    use_lockfile = true
  }
}