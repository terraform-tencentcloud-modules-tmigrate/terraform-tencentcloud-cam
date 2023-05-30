# cam-role-with-oidc

Create role OIDC configuration and create cam role for identity provider.

## Usage

```hcl
locals {
  account_id = "your_account_id"
  oidc_name = "your_oidc_name"
}

module "role_oidc_sso" {
  source = "../../modules/cam-role-with-oidc"

  create_role = true
  create_policy = true

  oidc_name         = local.oidc_name
  identity_url = "https://*******.qq.cn/"
  identity_key = "..."
  client_ids   = ["61adcf00******ddbc9546"]
  oidc_description = "create a cam role sso."

  role_document = <<EOF
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
  role_name = "tf-role"
  console_login = true
  role_description = "create oidc sso."

  policy_name = "tf-policy"
  policy_document = <<EOF
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create_oidc | Whether to create a oidc sso. | bool | true | no |
| create_role | Whether to create a role. | bool | true | no |
| create_policy | Whether to create a policy. | bool | false | yes |
| client_ids | Client ids. | set(string) | [""] | yes |
| identity_key | Sign the public key. | string | "" | yes |
| identity_url | Identity provider URL. | string | "" | yes |
| oidc_name | The name of cam oidc sso. | string | "" | yes |
| oidc_description | The description of cam oidc sso. | string | "" | no |
| role_document | Document of the CAM role. The syntax refers to CAM POLICY. There are some notes when using this para in terraform: 1. The elements in json claimed supporting two types as string and array only support type array; 2. Terraform does not support the root syntax, when appears, it must be replaced with the uin it stands for. | string | "" | yes |
| role_name | Name of CAM role. | string | "" | yes |
| console_login | Indicates whether the CAM role can login or not. | bool | false | no |
| role_description | Description of the CAM role. | string | "" | no |
| role_tags | A list of tags used to associate different resources. | map(string) | {} | no |
| policy_name | Name of CAM policy. | string | "" | yes |
| policy_document | Document of the CAM policy. The syntax refers to CAM POLICY. There are some notes when using this para in terraform: 1. The elements in JSON claimed supporting two types as string and array only support type array; 2. Terraform does not support the root syntax, when it appears, it must be replaced with the uin it stands for. | string | "" | yes |
| policy_description | Description of the CAM policy. | string | "" | no |
| policy_id | ID of the policy. | string | "" | no |


## Outputs

| Name | Description |
|------|-------------|
| oidc_sso_id | The ID of CAM-ROLE-OIDC. |
| role_id | The ID of cam role. |
| policy_id | The ID of cam policy. |

## Authors

Created and maintained by [TencentCloud](https://github.com/terraform-tencentcloud-modules/terraform-tencentcloud-vpc)

## License

Mozilla Public License Version 2.0. See LICENSE for full details.
