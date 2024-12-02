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
  default     = "public.ecr.aws/nginx/nginx:1.27-bookworm"
}

