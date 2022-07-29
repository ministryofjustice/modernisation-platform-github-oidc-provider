output "github_actions_provider" {
  description = "This module configures an OIDC provider for use with GitHub actions"
  value       = aws_iam_openid_connect_provider.github_actions.id
}
