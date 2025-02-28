output "github_actions_provider" {
  value = module.module_test.github_actions_provider
}

output "github_actions_trust_policy_conditions" {
  value = [
    for s in jsondecode(module.module_test.github_actions_role_trust_policy).Statement :
    { string_like = try(s.Condition.StringLike, null) }
  ]
}


output "oidc_role" {
  value = module.module_test.github_actions_role
}
output "debug_statements" {
  value = jsondecode(module.module_test.github_actions_role_trust_policy).Statement
}