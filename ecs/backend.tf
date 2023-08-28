terraform {
  backend "s3" {
    bucket  = "sctp-ce2-tfstate-bkt"
    key     = "ds2-test-ecs.tfstate"
    region  = "ap-southeast-1"
  }
}