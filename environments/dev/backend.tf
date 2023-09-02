terraform {
  backend "s3" {
    bucket  = "sctp-ce2-tfstate-bkt"
    key     = "davids/environments/dev/deploy.tfstate"
    region  = "ap-southeast-1"
  }
}