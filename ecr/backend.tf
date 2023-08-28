terraform {
  backend "s3" {
    bucket = "sctp-ce2-tfstate-bkt"
    key    = "ds2-test-ecr.tfstate"
    region = "ap-southeast-1"
  }
}