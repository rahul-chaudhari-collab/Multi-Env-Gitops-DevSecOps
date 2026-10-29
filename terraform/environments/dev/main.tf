terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "ecr" {
  source          = "../../modules/ecr"
  repository_name = "gitops-devsecops-app"
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}
