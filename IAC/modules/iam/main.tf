resource "aws_iam_openid_connect_provider" "oidc-git" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = ["2b18947a6a9fc7764fd8b5fb18a863b0c6dac24f"]


  tags = {
    "IAC" : "TRUE"

  }

}

resource "aws_iam_role" "app-runner-role" {
  name = "app-runner-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "build.apprunner.amazonaws.com"

        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    "IAC" : "TRUE"
  }
}

resource "aws_iam_role_policy_attachment" "app-runner-role-ecr" {
  role       = aws_iam_role.app-runner-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role" "tf_role" {
  name = "tf-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity",
      Condition = {
        StringEquals = {
          "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          "token.actions.githubusercontent.com:sub" = "repo:raelis18/rocketseat-ci-iam:ref:refs/heads/main"
        }
      }
      Effect = "Allow",
      Principal = {
        Federated = "arn:aws:iam::796973514485:oidc-provider/token.actions.githubusercontent.com"
      }
      }
    ]
    Version = "2012-10-17"
    }
  )
}

resource "aws_iam_role" "ecr_role" {
  name = "ecr-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity",
      Condition = {
        StringEquals = {
          "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          "token.actions.githubusercontent.com:sub" = "repo:raelis18/rocketseat.ci-cd:ref:refs/heads/main"
        }
      }
      Effect = "Allow",
      Principal = {
        Federated = "arn:aws:iam::796973514485:oidc-provider/token.actions.githubusercontent.com"
      }
      }
    ]
    Version = "2012-10-17"
    }
  )
}

resource "aws_iam_role_policy" "ecr_app_permissions" {
  role = aws_iam_role.ecr_role.name
  name = "ecr-app-permissions"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "Statement1",
        Effect   = "Allow",
        Action   = "apprunner:*"
        Resource = "*"
      },
      {
        Sid    = "Statement2",
        Effect = "Allow",
        Action = [
          "iam:PassRole",
          "iam:CreateServiceLinkedRole"
        ],
        Resource = "*"
      },
      {
        Sid    = "Statement3",
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:GetLifecyclePolicy",
          "ecr:GetLifecyclePolicyPreview",
          "ecr:ListTagsForResource",
          "ecr:DescribeImageScanFindings",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "tf_permissions" {
  role = aws_iam_role.tf_role.name
  name = "tf-permissions"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "Statement1",
        Effect   = "Allow",
        Action   = "ecr:*"
        Resource = "*"
      },
      {
        Sid      = "Statement2",
        Effect   = "Allow",
        Action   = "iam:*",
        Resource = "*"
      },
      {
        Sid      = "Statement3",
        Effect   = "Allow",
        Action   = "s3:*",
        Resource = "*"
      }
    ]
  })
}
