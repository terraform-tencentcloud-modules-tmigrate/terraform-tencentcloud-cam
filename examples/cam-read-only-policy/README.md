# CAM read-only policy exmaple

Configuration in this directory creates read-only CAM policies.


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
| <a name="module_read_only_policy"></a> [read\_only\_policy](#module\_read\_only\_policy) | ../../modules/cam-read-only-policy | n/a |
| <a name="module_read_only_policy_optional"></a> [read\_only\_policy\_optional](#module\_read\_only\_policy\_optional) | ../../modules/cam-read-only-policy | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The policy's ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
