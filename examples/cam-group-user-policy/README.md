# CAM policy exmaple

Configuration in this directory creates CAM groups, users and policies.


## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.12 |
| <a name="requirement_tencentcloud"></a> [tencentcloud](#requirement\_tencentcloud) | >=1.81.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cam_group_user_policy"></a> [cam\_group\_user\_policy](#module\_cam\_group\_user\_policy) | ../../modules/cam-group-user-policy | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group_ids"></a> [group\_ids](#output\_group\_ids) | The group ids |
| <a name="output_policiy_ids"></a> [policiy\_ids](#output\_policiy\_ids) | The policy ids |
| <a name="output_user_ids"></a> [user\_ids](#output\_user\_ids) | The user ids |
| <a name="output_user_passwords"></a> [user\_passwords](#output\_user\_passwords) | The user passwords |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
