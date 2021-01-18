# Configure the AWS Provider
provider "aws" {
  region  = var.region
}

terraform {
  required_version = "~>0.12"
  backend "s3" {
    bucket = "irw-aws-cicd-pipeline"
    key    = "devops.tfstate"
    region = "ap-south-1"
  }
}