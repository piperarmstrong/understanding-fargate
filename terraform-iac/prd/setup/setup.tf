terraform {
  backend "s3" {
    bucket         = "terraform-state-storage-639906780254"
    dynamodb_table = "terraform-state-lock-639906780254"
    key            = "understanding-fargate-prd/ecr.tfstate"
    region         = "us-west-2"
  }
}

provider "aws" {
  version = ">= 3.0"
  region  = "us-west-2"
}

variable "some_secret" {
  type        = string
  description = "Some secret string that will be stored in SSM and mounted into the Fargate Tasks as an environment variable"
}

module "setup" {
  source      = "../../modules/setup/"
  env         = "prd"
  some_secret = var.some_secret
}
