output "github_actions_provider" {
  description = "This module configures an OIDC provider for use with GitHub actions"
  value       = aws_iam_openid_connect_provider.github_actions.id
}

output "github_actions_role" {
  description = "IAM Role created for use by the OIDC provider"
  value       = aws_iam_role.github_actions.arn
}