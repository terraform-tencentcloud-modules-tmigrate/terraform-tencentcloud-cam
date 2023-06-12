output "oidc_sso_id" {
  value       = module.role_oidc_sso.oidc_sso_id
  description = "The ID of CAM-ROLE-OIDC."
}

output "role_id" {
  value       = module.role_oidc_sso.role_id
  description = "The ID of cam role."
}

output "policy_id" {
  value       = module.role_oidc_sso.policy_id
  description = "The ID of cam policy."
}