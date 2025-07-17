terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }

  # backend "s3" {
  #   bucket  = "terraform-app-flask-state-prod"
  #   key     = "state/terraform.tfstate"
  #   region  = "us-east-2"
  #   encrypt = true
  #   profile = "Administrador"
  # }

}

provider "aws" {
  profile = "Administrador"
  region  = "us-east-2"
}

resource "aws_s3_bucket" "terraform-app-flask-state-prod" {
  bucket = "app-terraform-state-dev"

  force_destroy = true

  # lifecycle {
  #   prevent_destroy = true
  # }

  tags = {
    IAC = "True"
  }
}

resource "aws_s3_bucket_versioning" "terraform-state-prod" {
  bucket = aws_s3_bucket.terraform-app-flask-state-prod.id
  versioning_configuration {
    status = "Enabled"
  }
}

module "iam" {
  source = "../modules/iam" 

}


