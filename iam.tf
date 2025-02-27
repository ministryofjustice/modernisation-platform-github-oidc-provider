
resource "aws_iam_role" "github_actions" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
}

data "aws_iam_policy_document" "github_oidc_assume_role" {
  #checkov:skip=CKV_AWS_358 "Skipping as this is controlled by variable validation"
  version = "2012-10-17"

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = formatlist("repo:%s", var.github_repositories)
    }
  }
  statement {
    sid     = "GuardDutyMalwareProtectionForS3"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["malware-protection-plan.guardduty.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:guardduty:eu-west-2:${data.aws_caller_identity.current.account_id}:malware-protection-plan/*"]
    }
  }
}
resource "aws_iam_role_policy_attachment" "read_only" {
  role       = aws_iam_role.github_actions.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "additional_managed_policies" {
  for_each   = toset(var.additional_managed_policies)
  role       = aws_iam_role.github_actions.name
  policy_arn = each.key
}

# Add actions missing from arn:aws:iam::aws:policy/ReadOnlyAccess
resource "aws_iam_policy" "extra_permissions" {
  name        = var.role_name
  path        = "/"
  description = "A policy for extra permissions for GitHub Actions"

  policy = var.additional_permissions
}

resource "aws_iam_role_policy_attachment" "extra_permissions" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.extra_permissions.arn
}
