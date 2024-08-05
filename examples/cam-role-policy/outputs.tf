

output "policiy_ids" {
  value = module.cam_role_policy.policy_ids
  description = "The policy ids"
}

output "role_ids" {
  value = module.cam_role_policy.role_ids
}