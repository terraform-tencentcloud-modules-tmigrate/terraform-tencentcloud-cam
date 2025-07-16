resource "random_password" "pwds" {
  for_each = var.users
  length           = 12
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  min_lower        = 1
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# create user
resource "tencentcloud_cam_user" "users" {
  for_each = var.users
  name                = each.key    // ForceNew, so there is no need a name variable in values
  remark              = try(each.value.user_remark, each.key)
  console_login       = try(each.value.console_login, true)
  use_api             = try(each.value.use_api, true)
  need_reset_password = try(each.value.need_reset_password, true)
  password            = try(each.value.console_login, true) ? (try(each.value.password, null) != null ? each.value.password : random_password.pwds[each.key].result) : null
  phone_num           = try(each.value.phone_num, "")
  email               = try(each.value.email, "")
  country_code        = try(each.value.country_code, "86")
  force_delete        = try(each.value.force_delete, true)
  tags = try(each.value.user_tags, {})
}

data "tencentcloud_cam_users" "all" {
  #  depends_on = [tencentcloud_cam_user.users]
}

# create policies
resource "tencentcloud_cam_policy" "policies" {
  for_each = var.policies
  name        = each.key   // ForceNew
  document    = try(each.value.document, null)
  description = try(each.value.description, "")
}

# read all pre policies
data "tencentcloud_cam_policies" "all" {
}

locals {
  policy_map = {for policy in data.tencentcloud_cam_policies.all.policy_list: policy.name => policy.policy_id}
  //  group_policies = flatten([
  //    for group_name, group in var.groups: [
  //      for policy_name in try(group.policy_names, []): {
  //        k = format("%s.%s", group_name, policy_name)
  //        group_id = tencentcloud_cam_group.groups[group_name].id
  //        policy_id = lookup(local.policy_map, policy_name, 0)
  //      }
  //    ]
  //  ])
  created_uins = {
    for k, user in tencentcloud_cam_user.users: user.name => user.uin
  }
  created_uids = {
    for k, user in tencentcloud_cam_user.users: user.name => user.uid
  }

  user_uins = {
    for user in data.tencentcloud_cam_users.all.user_list: user.name => user.uin
  }
  user_uids = {
    for user in data.tencentcloud_cam_users.all.user_list: user.name => user.uid
  }

  all_uins = merge(local.user_uins, local.created_uins)
  all_uids = merge(local.user_uids, local.created_uids)

  group_policies = concat(
    flatten([
      for group_name, group in var.groups: [
        for policy_name in try(group.pre_policy_names, []): {
          k = format("%s.%s", group_name, policy_name)
          group_id = tencentcloud_cam_group.groups[group_name].id
          policy_id = lookup(local.policy_map, policy_name, 0)
        }
      ]
    ]),
    flatten([
      for group_name, group in var.groups: [
        for policy_name in try(group.custom_policy_names, []): {
          k = format("%s.%s", group_name, policy_name)
          group_id = tencentcloud_cam_group.groups[group_name].id
          policy_id = tencentcloud_cam_policy.policies[policy_name].id
        }
      ]
    ]),
  )
  group_policy_map = {for group_policy in local.group_policies: group_policy.k => group_policy}

  group_with_users = {for group_name, group in var.groups: group_name => group if length(try(group.user_names, [])) > 0 }
  mfas = { for user_name, mfa in var.mfas: user_name => mfa if try(mfa.enable_mfa, false)}

}

# create groups
resource "tencentcloud_cam_group" "groups" {
  for_each = var.groups
  name   = try(each.value.name, each.key)
  remark = try(each.value.group_remark, each.key)
}

# attach policies
resource "tencentcloud_cam_group_policy_attachment" "foo" {
  for_each = local.group_policy_map
  group_id  = each.value.group_id
  policy_id = each.value.policy_id
}

# attach users
resource "tencentcloud_cam_group_membership" "foo" {
  for_each = local.group_with_users
  group_id = tencentcloud_cam_group.groups[each.key].id
  user_names = try(each.value.user_names, [])
  depends_on = [
    tencentcloud_cam_user.users
  ]
}

# enable mfa
resource "tencentcloud_cam_mfa_flag" "mfa_flag" {
  for_each = local.mfas
  op_uin = local.all_uins[each.key]
  login_flag {
    phone  = try(each.value.mfa_options.login_flag.phone, false) ? 1: 0
    stoken = try(each.value.mfa_options.login_flag.stoken, false) ? 1: 0
    wechat = try(each.value.mfa_options.login_flag.wechat, false) ? 1: 0
  }
  action_flag {
    phone  = try(each.value.mfa_options.action_flag.phone, false) ? 1: 0
    stoken = try(each.value.mfa_options.action_flag.stoken, false) ? 1: 0
    wechat = try(each.value.mfa_options.action_flag.wechat, false) ? 1: 0
  }
}
