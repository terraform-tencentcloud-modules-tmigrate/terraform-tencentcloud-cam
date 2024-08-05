
locals {
  create_roles = { for k, role in var.roles: k => role if try(role.create, true)}
  create_policy_atts = flatten([
    for k, role in local.create_roles: [
      for policy in role.policies: {
        k = format("%s_%s", k, policy)
        role = role.name
        policy = policy
      } if ! contains(var.ignored_policies, policy)
    ]
  ])
  create_policy_att_map = { for p in local.create_policy_atts: p.k => p }
}



resource "tencentcloud_cam_role" "all" {
  for_each = local.create_roles
  name        = each.value.name
  session_duration = try(each.value.session_duration, 7200)
  document    = jsonencode(
{
  "statement": [
    {
      "action":"name/sts:AssumeRole",
      "effect":"allow",
      "principal":{
        (each.value.principal_type): each.value.principal
      }
    }
  ],
  "version":"2.0"
})
  description = try(each.value.description, "")
  tags = var.tags
  lifecycle {
    ignore_changes = [
      document # this value should not be changed.
    ]
  }
}

# create policies

resource "tencentcloud_cam_policy" "policies" {
  for_each = var.policies
  name        = each.key   // ForceNew
  document    = try(each.value.document, null)
  description = try(each.value.description, "")
}

resource "tencentcloud_cam_role_policy_attachment_by_name" "all" {
  depends_on = [tencentcloud_cam_role.all, tencentcloud_cam_policy.policies]
  for_each = local.create_policy_att_map

  role_name   = each.value.role
  policy_name = each.value.policy
}
