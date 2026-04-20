
# This module configures an OIDC provider for use with GitHub actions.
resource "aws_iam_openid_connect_provider" "github_actions" {
  count           = var.create_github_oidc_provider ? 1 : 0
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = distinct(concat(data.tls_certificate.github.certificates[*].sha1_fingerprint, var.github_known_thumbprints))
  url             = "https://token.actions.githubusercontent.com"
  tags            = var.tags_common
}

# Look up the existing OIDC provider when not creating one (e.g. it already exists in the account).
data "aws_iam_openid_connect_provider" "github_actions" {
  count = var.create_github_oidc_provider ? 0 : 1
  url   = "https://token.actions.githubusercontent.com"
}
