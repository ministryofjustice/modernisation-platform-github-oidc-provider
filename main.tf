
# This module configures an OIDC provider for use with GitHub actions.
resource "aws_iam_openid_connect_provider" "github_actions" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = distinct(concat(data.tls_certificate.github.certificates[*].sha1_fingerprint, var.github_known_thumbprints))
  url             = "https://token.actions.githubusercontent.com"
  tags            = var.tags_common
}
