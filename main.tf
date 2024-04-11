terraform {
  backend "local" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.43.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key

  # SEE: https://registry.terraform.io/providers/hashicorp/aws/latest/docs#s3_use_path_style
  s3_use_path_style = true

  # 認証をスキップするため、実運用場はこのオプションを設定しない
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = var.endpoint
  }
}

resource "aws_s3_bucket" "terraform_tfstate" {
  bucket = "terraform-tfstate"
}
