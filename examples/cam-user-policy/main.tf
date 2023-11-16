module "cam_group_user_policy" {
  source = "../../modules/cam-user-policy"

  users = {
    "test_user1@abc.com" = {
      email = "test_user1@abc.com"
      console_login = false
      user_remark = "test"
      pre_policy_names = ["QcloudCOSBucketConfigRead"]
      custom_policy_names = ["cos_ro"]
      create_access_key = true
    }
    "test_user2@abc.com" = {
      email = "test_user2@abc.com"
      console_login = false
      pre_policy_names = ["QcloudCOSBucketConfigWrite"]
      custom_policy_names = ["cos_wo", "cos_wo_1"]
      create_access_key = false
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
    cos_wo_1 = {
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
}