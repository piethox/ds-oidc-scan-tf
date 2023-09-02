provider "aws" {
  region = "ap-southeast-1"

  default_tags {
    tags = {
      Name = "ds-test"
      Environment = var.env
    }
  }
}