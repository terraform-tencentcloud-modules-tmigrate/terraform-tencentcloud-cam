output "user_ids" {
  description = "The user ids"
  value       = module.cam_group_user_policy.user_ids
}

output "user_passwords" {
  description = "The user passwords"
  value       = module.cam_group_user_policy.user_passwords
}

output "policiy_ids" {
  value       = module.cam_group_user_policy.policy_ids
  description = "The policy ids"
}

output "access_keys" {
  value = module.cam_group_user_policy.access_keys
}
