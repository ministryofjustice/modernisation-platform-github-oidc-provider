output "github_actions_provider" {
  value = module.module_test.github_actions_provider
}

output "github_actions_trust_policy_conditions" {
  value = jsondecode(module.module_test.github_actions_role_trust_policy).Statement[*].Condition.StringLike
}
output "oidc_role" {
  value = module.module_test.github_actions_role
}

output "github_actions_provider_without_provider" {
  value = module.module_test_without_provider.github_actions_provider
}

output "github_actions_trust_policy_conditions_without_provider" {
  value = jsondecode(module.module_test_without_provider.github_actions_role_trust_policy).Statement[*].Condition.StringLike
}
output "oidc_role_without_provider" {
  value = module.module_test_without_provider.github_actions_role
}
