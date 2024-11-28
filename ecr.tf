
# resource "aws_ecr_repository" "hpo_repository" {
#   name                 = var.image_repo_name
#   image_tag_mutability = "MUTABLE"
#   image_scanning_configuration {
#     scan_on_push = true
#   }

#   lifecycle {
#     prevent_destroy = false
#   }
# }

# output "repository_url" {
#   value = aws_ecr_repository.hpo_repository.repository_url
# }