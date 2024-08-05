data "tencentcloud_user_info" "info" {}

locals {
  uin = data.tencentcloud_user_info.info.owner_uin
}

module "cam_role_policy" {
  source = "../../modules/cam-role-policy"
  tags = {
    created: "terraform"
  }
  roles = {
    qcs_role = {
      create = true
      name = "test_qcs_role"
      principal_type = "qcs"
      principal = [ "qcs::cam::uin/${local.uin}:root" ]
      policies = [ "cos_ro" ]
    }
    service_role = {
      create = true
      name = "TSE_QCSRole"
      principal_type = "service"
      principal = "tse.qcloud.com"
      policies    = [
        "QcloudAccessForTSERole"
      ]
    }

  }

  policies = {
    cos_ro = {
      // refer https://cloud.tencent.com/document/product/436/11714
      document = <<EOF
{
  "version": "2.0",
  "statement": [
    {
      "action": [
        "name/cos:List*",
        "name/cos:Get*",
        "name/cos:Head*",
        "name/cos:OptionsObject"
      ],
      "effect": "allow",
      "resource": ["*"]
    },
    {
      "effect": "allow",
      "action": ["monitor:*"],
      "resource": ["*"]
      }

  ]
}
EOF
      description = "cos read only policy"
    },
  }

}