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

# variable "eks_map_accounts" {
#   description = "Additional AWS account numbers to add to the aws-auth configmap."
#   type        = list(string)

#   default = [
#     "1111111111",
#   ]
# }

# variable "eks_map_roles" {
#   description = "Additional IAM roles to add to the aws-auth configmap."
#   type = list(object({
#     rolearn  = string
#     username = string
#     groups   = list(string)
#   }))

#   default = [
#     {
#       rolearn  = "arn:aws:iam::11111111:role/role1"
#       username = "role1"
#       groups   = ["system:masters"]
#     },
#   ]
# }

# variable "eks_map_users" {
#   description = "Additional IAM users to add to the aws-auth configmap."
#   type = list(object({
#     userarn  = string
#     username = string
#     groups   = list(string)
#   }))

#   default = [
#     {
#       userarn  = "arn:aws:iam::111111111:user/user1"
#       username = "user1"
#       groups   = ["system:masters"]
#     },
#     {
#       userarn  = "arn:aws:iam::111111111:user/user2"
#       username = "user2"
#       groups   = ["system:masters"]
#     },
#   ]
# }