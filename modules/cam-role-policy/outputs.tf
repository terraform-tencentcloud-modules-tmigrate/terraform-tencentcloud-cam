output "role_ids" {
  value = { for name, role in tencentcloud_cam_role.all: name => role.id}
}

output "policy_ids" {
  value       = { for name, policy in tencentcloud_cam_policy.policies:  name => policy.id }
  description = "policy ids"
}
