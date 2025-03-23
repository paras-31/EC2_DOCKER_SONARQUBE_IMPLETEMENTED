terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.59.0"
    }
  }
  backend "s3" {
    bucket         = "parasec2tfstate"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }
}

