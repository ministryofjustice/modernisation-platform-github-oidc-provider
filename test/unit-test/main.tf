
module "module_test" {
  source                 = "../../"
  github_repository      = "ministryofjustice/modernisation-platform-environments:*"
  additional_permissions = data.aws_iam_policy_document.extra_permissions.json
  tags_common            = local.tags
  tags_prefix            = terraform.workspace
}

data "aws_iam_policy_document" "extra_permissions" {
  #checkov:skip=CKV_AWS_107
  #checkov:skip=CKV_AWS_108
  #checkov:skip=CKV_AWS_109
  #checkov:skip=CKV_AWS_111
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
