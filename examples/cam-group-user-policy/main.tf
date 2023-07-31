module "cam_group_user_policy" {
  source = "../../modules/cam-group-user-policy"

  users = {
    "test_user1@abc.com" = {
      email = "test_user1@abc.com"
      user_remark = "test"
      phone_num = "13800138000"
      password = "Passw0rd!@#"
    }
    "test_user2@abc.com" = {
      email = "test_user2@abc.com"
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
    cos_wo = {
      // refer https://cloud.tencent.com/document/product/436/11714
      document = <<EOF
{
  "version": "2.0",
  "statement": [
    {
      "effect": "allow",
      "action": [
          "cos:ListParts",
          "cos:PostObject",
          "cos:PutObject*",
          "cos:InitiateMultipartUpload",
          "cos:UploadPart",
          "cos:UploadPartCopy",
          "cos:CompleteMultipartUpload",
          "cos:AbortMultipartUpload",
          "cos:ListMultipartUploads"
      ],
      "resource": ["*"]
    }
  ]
}
EOF
      description = "cos write only (no delete) policy"
    }
  }

  groups = {
    group_cos_ro = {
      group_remark = "test group cos ro"
      policy_names = ["cos_ro", "QcloudCOSBucketConfigRead"]
      user_names = ["test_user1@abc.com"]
    },
    group_cos_wo = {
      group_remark = "test group cos wo"
      policy_names = ["cos_wo", "QcloudCOSBucketConfigWrite"]
      user_names = ["test_user1@abc.com", "test_user2@abc.com"]
    }
  }
}