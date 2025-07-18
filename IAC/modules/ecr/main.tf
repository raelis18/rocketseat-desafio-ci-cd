resource "aws_ecr_repository" "rocketseat-ci-app" {
  name                 = var.ecr_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    IAC = "true"
  }
}