provider "aws" {
  region                  = var.region
  shared_credentials_file = "/home/uchinda/.aws/credentials"
  profile                 = "default"
}