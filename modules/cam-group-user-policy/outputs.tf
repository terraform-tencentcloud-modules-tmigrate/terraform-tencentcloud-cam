output "group_ids" {
  value       = {for group_name, group in tencentcloud_cam_group.groups: group_name => group.id}
  description = "group ids"
}

output "user_ids" {
  value       = { for user_name, user in tencentcloud_cam_user.users: user_name => user.id }
  description = "user ids"
}
output "user_passwords" {
  value       = { for user_name, user in tencentcloud_cam_user.users: user_name => user.password }
  description = "user passwords"
  sensitive = true
}

output "policy_ids" {
  value       = { for name, policy in tencentcloud_cam_policy.policies:  name => policy.id }
  description = "policy ids"
}

output "group_users_uins" {
  value = {
    for k, group in local.group_with_users: k => {
      for user_name in group.user_names: user_name => try(tencentcloud_cam_user.users[user_name].uin, "non-created-user")
    }
  }
}
