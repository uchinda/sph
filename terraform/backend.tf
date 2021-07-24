terraform {
  backend "s3" {
    bucket = "sph-terraform-state"
    key    = "assignment/terraform.tfstate"
    region = "eu-central-1"
  }
}