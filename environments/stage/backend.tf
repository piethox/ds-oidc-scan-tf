terraform {
  backend "s3" {
    bucket  = "ce2-dstest-capstone-project-tfstate-bucket"
    key     = "environments/stage/deploy.tfstate"
    region  = "ap-southeast-1"
  }
}