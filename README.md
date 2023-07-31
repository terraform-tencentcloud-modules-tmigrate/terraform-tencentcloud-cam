# terraform-tencentcloud-cam

TencentCloud support CAM setting.

## Usage

`cam-role-with-oidc`:

```hcl
module "role_oidc_sso" {
  source = "terraform-tencentcloud-modules/cam/tencentcloud//examples/cam-role-with-oidc"

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
```

`cam-role-with-saml`:

## Usage

```hcl
module "role_saml" {
  source = "terraform-tencentcloud-modules/cam/tencentcloud//examples/cam-role-with-saml"

  saml_name        = local.saml_name
  meta_data        = "your_mete_data"
  saml_description = "create saml provider."

  role_document    = <<EOF
  {
  "version": "2.0",
  "statement": [
    {
      "action": "name/sts:AssumeRoleWithSAML",
      "effect": "allow",
      "principal": {
        "federated": [
          "qcs::cam::uin/${local.account_id}:saml-provider/${local.saml_name}"
        ]
      },
      "condition": {
        "string_equal": {
          "saml:aud": "https://cloud.tencent.com/login/saml"
        }
      }
    }
  ]
  }
  EOF
  role_name        = "tf-role"
  console_login    = true
  role_description = "create saml role."

  create_policy      = true
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
```

## Examples

- [cam-role-with-oidc](https://github.com/terraform-tencentcloud-modules/terraform-tencentcloud-cam/tree/main/examples/cam-role-with-oidc) - Create role OIDC configuration and create cam role for identity provider
- [cam-role-with-saml](https://github.com/terraform-tencentcloud-modules/terraform-tencentcloud-cam/tree/main/examples/cam-role-with-saml) - Create SAML identity provider and create cam role for identity provider
- [cam-role-with-saml](https://github.com/terraform-tencentcloud-modules/terraform-tencentcloud-cam/tree/main/examples/cam-group-user-policy) - Create cam groups、users、policies and connect them

## Authors

Created and maintained by [TencentCloud](https://github.com/terraform-tencentcloud-modules/terraform-tencentcloud-vpc)

## License

Mozilla Public License Version 2.0. See LICENSE for full details.