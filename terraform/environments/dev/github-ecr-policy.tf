data "aws_iam_policy_document" "ecr_push" {
  statement {
    sid       = "GetECRAuthorizationToken"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid    = "PushImagesToRepository"
    effect = "Allow"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]

    resources = [
      module.ecr.repository_arn
    ]
  }
}

resource "aws_iam_role_policy" "github_ecr_push" {
  name   = "GitOpsDevSecOpsECRPush"
  role   = aws_iam_role.github_actions.id
  policy = data.aws_iam_policy_document.ecr_push.json
}

output "github_actions_role_arn" {
  value = aws_iam_role.github_actions.arn
}
