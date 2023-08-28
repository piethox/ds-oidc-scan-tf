terraform {
  backend "s3" {
    bucket  = "sctp-ce2-tfstate-bkt"
    key     = "ds2-test-chat.tfstate"
    region  = "ap-southeast-1"
  }
}