output "user_ids" {
  description = "The user ids"
  value = module.cam_group_user_policy.user_ids
}

output "user_passwords" {
  description = "The user passwords"
  value = module.cam_group_user_policy.user_passwords
  sensitive = true
}