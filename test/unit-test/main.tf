
module "module_test" {
  source = "../../"

  app_name      = var.networking[0].application
  github_repository = "ministryofjustice/modernisation-platform-environments:*"
  additional_permissions = data.aws_iam_policy_document.extra_permissions.json

  # Tags
  tags_common = local.tags
  tags_prefix = terraform.workspace
}

data "aws_iam_policy_document" "extra_permissions" {
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
      "account:GetAlternateContact",
      "cur:DescribeReportDefinitions",
      "identitystore:ListGroups",
      "secretsmanager:GetSecretValue",
      "sts:AssumeRole",
      "s3:*",
      "kms:*",
    ]

    resources = ["*"]
  }
}

#resource "aws_iam_role_policy_attachment" "extra_permissions" {
#  role       = aws_iam_role.github_actions.name
#  policy_arn = aws_iam_policy.extra_permissions.arn
#}
