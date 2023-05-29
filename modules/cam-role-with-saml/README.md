# cam-role-with-saml

Create SAML identity provider and create cam role for identity provider.

## Usage

```hcl
locals {
  account_id = "your_account_id"
  saml_name = "your_saml_name"
}

module "role_saml" {
  source = "../../modules/cam-role-with-saml"

  saml_name = local.saml_name
  meta_data = "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48bWQ6RW50aXR5RGVzY3JpcHRvciBlbnRpdHlJRD0iaHR0cDovL3d3dy5va3RhLmNvbS9leGsxa3F4bWNqUW1HQURNeTM1NyIgeG1sbnM6bWQ9InVybjpvYXNpczpuYW1lczp0YzpTQU1MOjIuMDptZXRhZGF0YSI+PG1kOklEUFNTT0Rlc2NyaXB0b3IgV2FudEF1dGhuUmVxdWVzdHNTaWduZWQ9ImZhbHNlIiBwcm90b2NvbFN1cHBvcnRFbnVtZXJhdGlvbj0idXJuOm9hc2lzOm5hbWVzOnRjOlNBTUw6Mi4wOnByb3RvY29sIj48bWQ6S2V5RGVzY3JpcHRvciB1c2U9InNpZ25pbmciPjxkczpLZXlJbmZvIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIj48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlEb0RDQ0FvaWdBd0lCQWdJR0FXM0lTcExvTUEwR0NTcUdTSWIzRFFFQkN3VUFNSUdRTVFzd0NRWURWUVFHRXdKVlV6RVRNQkVHDQpBMVVFQ0F3S1EyRnNhV1p2Y201cFlURVdNQlFHQTFVRUJ3d05VMkZ1SUVaeVlXNWphWE5qYnpFTk1Bc0dBMVVFQ2d3RVQydDBZVEVVDQpNQklHQTFVRUN3d0xVMU5QVUhKdmRtbGtaWEl4RVRBUEJnTlZCQU1NQ0dsa2VIVmxkblJoTVJ3d0dnWUpLb1pJaHZjTkFRa0JGZzFwDQpibVp2UUc5cmRHRXVZMjl0TUI0WERURTVNVEF4TkRBek1qSXhNMW9YRFRJNU1UQXhOREF6TWpNeE0xb3dnWkF4Q3pBSkJnTlZCQVlUDQpBbFZUTVJNd0VRWURWUVFJREFwRFlXeHBabTl5Ym1saE1SWXdGQVlEVlFRSERBMVRZVzRnUm5KaGJtTnBjMk52TVEwd0N3WURWUVFLDQpEQVJQYTNSaE1SUXdFZ1lEVlFRTERBdFRVMDlRY205MmFXUmxjakVSTUE4R0ExVUVBd3dJYVdSNGRXVjJkR0V4SERBYUJna3Foa2lHDQo5dzBCQ1FFV0RXbHVabTlBYjJ0MFlTNWpiMjB3Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLQW9JQkFRQ2g4b3dqDQpZK2dQSUM3blQvNTduLzdmeXJzcDlHMXdxa2UxdXhjMHVrTndnQXozOVNpelY3QVhLMWRReTFLaThXWjJJMzFEczJkT0FNQ1FKR2pWDQpUWWNNbnA3KzhqUzNLdmxNUkRJamk5cmxuUi9vcnBvMll1RHVWby9jVzdidlRIS2h2REo1QWZRaWxzYlNPTXdUOWM2TVlYZGhBNVBwDQpzelFsK1UrdHJmcXUrdUorSER4SVQxdlhWaVI5YlY2SUFRSzZpbWZoc2wxWmVSUytjbVFVNEpjQWlYT0xtTnFVVWM2UkpxUzhrMW1mDQpBLzhmb2VyMGc3SG4xZDVXclpCc2gyUlR2Vzh1ZVdadHQ3dmh4QTlGdE5kSVlEcXJ0eElmMlZXcXhrSHM3WFZDSm5wTnJITVovT1BRDQpGY21YSGVxNlJJMlB3Q1RlOW8zZHZpM0hqeXBaOEl4dkFnTUJBQUV3RFFZSktvWklodmNOQVFFTEJRQURnZ0VCQUFHaHk1bG9nbGtTDQoyVHg2YS90MnF5VEx0YVV5cEwrNGhySGJoMVAweVVMc0NrSnFsM2wrWG9VZDZCY2FJaFNSVGFPQk95ODViL0UzelJ4K3JzQXJwTjVVDQp5ZThuUEM4a05PYW5vTk9wWnZvYmhpTzFlMFIvYmxEcnRBL0o5UlBwMWtmdlhmS2NSTTU3TlRCWXppTURlbnFQUTRFOWN1U2lGdFFxDQpJYmpIbThaM1B1YXgwRitldkZ3U1pJMDNCWXNISGw1d1EraEJBS3hTdTJINEZRdU93Zmpnb2EveEN6Z1NKYjJ2UXdEc1MxMk9mSkNiDQpSRm1ZL1VYZXQramFhdEVORktLZStZSUJpU0J2WG1adTN0MHN5NDZTNzlPVzBacXJ0NUh2bElsT2lpTFpaN1FZamxjM1kxeG1LZ1luDQpXM2M2WGZkdmhGWHo0ZDdkbWYvTUdpNGY0enM9PC9kczpYNTA5Q2VydGlmaWNhdGU+PC9kczpYNTA5RGF0YT48L2RzOktleUluZm8+PC9tZDpLZXlEZXNjcmlwdG9yPjxtZDpOYW1lSURGb3JtYXQ+dXJuOm9hc2lzOm5hbWVzOnRjOlNBTUw6MS4xOm5hbWVpZC1mb3JtYXQ6dW5zcGVjaWZpZWQ8L21kOk5hbWVJREZvcm1hdD48bWQ6TmFtZUlERm9ybWF0PnVybjpvYXNpczpuYW1lczp0YzpTQU1MOjEuMTpuYW1laWQtZm9ybWF0OmVtYWlsQWRkcmVzczwvbWQ6TmFtZUlERm9ybWF0PjxtZDpTaW5nbGVTaWduT25TZXJ2aWNlIEJpbmRpbmc9InVybjpvYXNpczpuYW1lczp0YzpTQU1MOjIuMDpiaW5kaW5nczpIVFRQLVBPU1QiIExvY2F0aW9uPSJodHRwczovL2lkeHVldnRhLm9rdGEuY29tL2FwcC9pZHh1ZW9yZzYzNzM1OF90ZXN0XzEvZXhrMWtxeG1jalFtR0FETXkzNTcvc3NvL3NhbWwiLz48bWQ6U2luZ2xlU2lnbk9uU2VydmljZSBCaW5kaW5nPSJ1cm46b2FzaXM6bmFtZXM6dGM6U0FNTDoyLjA6YmluZGluZ3M6SFRUUC1SZWRpcmVjdCIgTG9jYXRpb249Imh0dHBzOi8vaWR4dWV2dGEub2t0YS5jb20vYXBwL2lkeHVlb3JnNjM3MzU4X3Rlc3RfMS9leGsxa3F4bWNqUW1HQURNeTM1Ny9zc28vc2FtbCIvPjwvbWQ6SURQU1NPRGVzY3JpcHRvcj48L21kOkVudGl0eURlc2NyaXB0b3I+"
  saml_description = "create saml provider."

  role_document = <<EOF
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
  role_name = "tf-role"
  console_login = true
  role_description = "create saml role."

  create_policy = true
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
| create_saml | Whether to create a saml provider. | bool | true | no |
| create_role | Whether to create a role. | bool | true | no |
| create_policy | Whether to create a policy. | bool | false | yes |
| saml_name | The name of CAM SAML provider. | string | "" | yes |
| meta_data | The meta data document of the CAM SAML provider. | string | "" | yes |
| saml_description | The description of the CAM SAML provider. | string | "" | yes |
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
| saml_provider_id | The ID of SAML provider. |
| role_id | The ID of cam role. |
| policy_id | The ID of cam policy. |

## Authors

Created and maintained by [TencentCloud](https://github.com/terraform-tencentcloud-modules/terraform-tencentcloud-vpc)

## License

Mozilla Public License Version 2.0. See LICENSE for full details.
