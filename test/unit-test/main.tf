resource "random_id" "role" {
  byte_length = 1
}

module "module_test" {
  source                 = "../../"
  additional_permissions = data.aws_iam_policy_document.extra_permissions.json
  github_repositories    = ["ministryofjustice/modernisation-platform-environments:*", "ministryofjustice/modernisation-platform-ami-builds:*"]
  role_name              = format("github-actions-%s", random_id.role.dec)
  tags_common            = local.tags
  tags_prefix            = terraform.workspace
}

#trivy:ignore:AVD-AWS-0345
data "aws_iam_policy_document" "extra_permissions" {
  #checkov:skip=CKV_AWS_107
  #checkov:skip=CKV_AWS_108
  #checkov:skip=CKV_AWS_109
  #checkov:skip=CKV_AWS_111
  #checkov:skip=CKV_AWS_356 skipping check as this code is used in a unit test, not production
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

module "module_test_without_provider" {
  source                      = "../../"
  additional_permissions      = data.aws_iam_policy_document.extra_permissions.json
  github_repositories         = ["ministryofjustice/modernisation-platform-environments:*", "ministryofjustice/modernisation-platform-ami-builds:*"]
  role_name                   = format("github-actions-%s", random_id.role.dec)
  tags_common                 = local.tags
  tags_prefix                 = terraform.workspace
  create_github_oidc_provider = false
}

#trivy:ignore:AVD-AWS-0345
data "aws_iam_policy_document" "extra_permissions" {
  #checkov:skip=CKV_AWS_107
  #checkov:skip=CKV_AWS_108
  #checkov:skip=CKV_AWS_109
  #checkov:skip=CKV_AWS_111
  #checkov:skip=CKV_AWS_356 skipping check as this code is used in a unit test, not production
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
