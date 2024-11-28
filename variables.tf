variable "ami" {
  type    = string
  default = "ami-012967cc5a8c9f891"
}

variable "image_repo_name" {
  description = "Image repo name"
  type        = string
  default     = "hpo-api-image"
}

variable "ecr_repo_url" {
  description = "ECS Cluster Name"
  type        = string
  default     = "686255987510.dkr.ecr.eu-west-2.amazonaws.com/hpo-staging-api-repo:956e3d48ea36243d9e7617c75e2733ff2ccc342c"
}

