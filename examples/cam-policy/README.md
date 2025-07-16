# CAM policy exmaple

Configuration in this directory creates CAM policies.


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
| <a name="module_cam_policy"></a> [cam\_policy](#module\_cam\_policy) | ../../modules/cam-policy | n/a |
| <a name="module_iam_policy_optional"></a> [iam\_policy\_optional](#module\_iam\_policy\_optional) | ../../modules/cam-policy | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The policy's ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
