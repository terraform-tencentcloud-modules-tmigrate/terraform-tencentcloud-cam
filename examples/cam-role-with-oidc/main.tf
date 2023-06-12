provider "tencentcloud" {
  region = var.region
}

locals {
  account_id = "your_account_id"
  oidc_name  = "your_oidc_name"
}

module "role_oidc_sso" {
  source = "../../modules/cam-role-with-oidc"

  create_role   = true
  create_policy = true

  oidc_name        = local.oidc_name
  identity_url     = "https://*******.qq.cn/"
  identity_key     = "..."
  client_ids       = ["61adcf00******ddbc9546"]
  oidc_description = "create a cam role sso."

  role_document    = <<EOF
  {
  "version": "2.0",
  "statement": [
    {
      "action": "name/sts:AssumeRole",
      "effect": "allow",
      "principal": {
        "federated": [
          "qcs::cam::uin/${local.account_id}:oidc-provider/${local.oidc_name}"
        ]
      },
      "condition": {
        "string_equal": {
          "oidc:iss": "https://*******.qq.cn/"
        }
      }
    }
  ]
  }
  EOF
  role_name        = "tf-role"
  console_login    = true
  role_description = "create oidc sso."

  policy_name        = "tf-policy"
  policy_document    = <<EOF
  {
    "version": "2.0",
    "statement": [
        {
        "action": [
            "name/sts:AssumeRole"
        ],
        "effect": "allow",
        "resource": [
            "*"
        ]
        }
    ]
  }
  EOF
  policy_description = "create cam policy."
}