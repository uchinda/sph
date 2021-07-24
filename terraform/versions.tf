terraform {
  required_version = "~> 1.15"

  required_providers {
    aws        = {
        source  = "hashicorp/aws"
        version = "~> 3.24"
    }
    kubernetes = "~> 1.19"
  }
}