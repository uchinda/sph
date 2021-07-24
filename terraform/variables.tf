variable "region" {
  default = "ap-southeast-1"
}

variable "vpc_name" {
  default = "sph-vpc"
}

variable "eks_cluster_name" {
  default = "sph-eks-cluster"
}

variable "eks_cluster_version" {
  default = "1.20"
}

variable "db_name" {
  default = "sph-mysql-database"
}

variable "rds_db_name" {
  default = "sph"
}

variable "db_password" {
  type      = string
  sensitive = true
}