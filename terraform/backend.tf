terraform {
  backend "s3" {
    bucket = "terraform-state-sph"
    key    = "assignment/terraform.tfstate"
    region = "ap-southeast-1"
  }
}