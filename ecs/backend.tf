terraform {
  backend "s3" {
    bucket  = "sctp-ce2-tfstate-bkt"
    key     = "grp2-chat-app-oidc.tfstate"
    region  = "ap-southeast-1"
  }
}