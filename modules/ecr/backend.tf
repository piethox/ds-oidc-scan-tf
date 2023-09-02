terraform {
  backend "s3" {
    bucket  = "sctp-ce2-tfstate-bkt"
    key     = "davids/environments/modules/ecr/ecr.tfstate"
    region  = "ap-southeast-1"
  }
}