output "github_actions_provider" {
  value = module.module_test.github_actions_provider
}

output "github_actions_trust_policy_conditions" {
  value = jsondecode(module.module_test.github_actions_role_trust_policy).Statement[*].Condition.StringLike
}
output "oidc_role" {
  value = module.module_test.github_actions_role
}
