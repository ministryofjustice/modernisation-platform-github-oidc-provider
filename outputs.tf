output "github_actions_provider" {
  description = "This module configures an OIDC provider for use with GitHub actions"
  value       = try(aws_iam_openid_connect_provider.github_actions[0].id, null)
}

output "github_actions_role" {
  description = "IAM Role created for use by the OIDC provider"
  value       = aws_iam_role.github_actions.arn
}

output "github_actions_role_trust_policy" {
  description = "Assume role policy for the github-actions role"
  value       = data.aws_iam_policy_document.github_oidc_assume_role.json
}