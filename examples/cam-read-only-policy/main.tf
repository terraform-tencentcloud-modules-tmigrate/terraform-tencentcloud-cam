#########################################
# CAM read only policy
#########################################
module "read_only_policy" {
  source           = "../../modules/cam-read-only-policy"
  name             = "bob-tf-policy"
  description      = "My example policy"
  allowed_services = ["cos", "cvm"]
  additional_policy = [{
    action : [
      "monitor:Get*",
      "monitor:Describe*"
    ],
    effect : "allow",
    resource : [
      "*"
    ]
    },
    {
      action : [
        "cam:ListUsersForGroup",
        "cam:ListGroups",
        "cam:GetGroup",
        "cam:ListAttachedRolePolicies"
      ],
      effect : "allow",
      resource : [
        "*"
      ]
  }]
}


module "read_only_policy_optional" {
  source = "../../modules/cam-read-only-policy"

  create_policy = false
}
