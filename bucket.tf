# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "awsninja12-to-import-1234"
resource "aws_s3_bucket" "logs_bucket" {
  bucket              = "awsninja12-to-import-1234"
  force_destroy       = false
  object_lock_enabled = false
  region              = "us-east-1"
  tags = {
    owner = "bsz"
  }
  tags_all = {
    owner = "bsz"
  }
}
