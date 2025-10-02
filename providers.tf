terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.2"

  backend "s3" {
    bucket         = "bucket-leomandel-terraform"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "proway-Leomandel"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
