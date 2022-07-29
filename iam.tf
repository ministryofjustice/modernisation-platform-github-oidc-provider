
resource "aws_iam_role" "github_actions" {
  name               = "github-actions"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "github_oidc_assume_role" {
  version = "2012-10-17"

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_repository}"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "read_only" {
  role       = aws_iam_role.github_actions.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# Add actions missing from arn:aws:iam::aws:policy/ReadOnlyAccess
resource "aws_iam_policy" "extra_permissions" {
  name        = "github-actions"
  path        = "/"
  description = "A policy for extra permissions for GitHub Actions"

  policy = var.additional_permissions
}
