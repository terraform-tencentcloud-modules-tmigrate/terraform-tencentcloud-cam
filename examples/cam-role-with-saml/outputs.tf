output "saml_provider_id" {
  value       = module.role_saml.saml_provider_id
  description = "The ID of SAML provider."
}

output "role_id" {
  value       = module.role_saml.role_id
  description = "The ID of cam role."
}

output "policy_id" {
  value       = module.role_saml.policy_id
  description = "The ID of cam policy."
}