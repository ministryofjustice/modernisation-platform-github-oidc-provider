output "github_actions_provider" {
  value = module.module_test.github_actions_provider
}

output "github_actions_trust_policy_conditions" {
  value = [
    for statement in jsondecode(module.module_test.github_actions_role_trust_policy).Statement :
    try(statement.Condition.StringLike, "null")
  ]
}

output "oidc_role" {
  value = module.module_test.github_actions_role
}
