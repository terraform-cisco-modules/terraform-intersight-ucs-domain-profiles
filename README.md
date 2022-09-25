<!-- BEGIN_TF_DOCS -->
# Terraform Intersight Pools Module

A Terraform module to configure Intersight Pools.

This module is part of the Cisco [*Intersight as Code*](https://cisco.com/go/intersightascode) project. Its goal is to allow users to instantiate network fabrics in minutes using an easy to use, opinionated data model. It takes away the complexity of having to deal with references, dependencies or loops. By completely separating data (defining variables) from logic (infrastructure declaration), it allows the user to focus on describing the intended configuration while using a set of maintained and tested Terraform Modules without the need to understand the low-level Intersight object model.

A comprehensive example using this module is available here: https://github.com/scotttyso/iac-intersight-comprehensive-example

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.32 |
## Providers

No providers.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_model"></a> [model](#input\_model) | Model data. | `any` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_pools"></a> [ip\_pools](#output\_ip\_pools) | Moid of the IP Pools. |
| <a name="output_iqn_pools"></a> [iqn\_pools](#output\_iqn\_pools) | Moid of the IQN Pools. |
| <a name="output_mac_pools"></a> [mac\_pools](#output\_mac\_pools) | Moid of the MAC Pools. |
| <a name="output_resource_pools"></a> [resource\_pools](#output\_resource\_pools) | Moid of the Resource Pools. |
| <a name="output_uuid_pools"></a> [uuid\_pools](#output\_uuid\_pools) | Moid of the UUID Pools. |
| <a name="output_wwnn_pools"></a> [wwnn\_pools](#output\_wwnn\_pools) | Moid of the WWNN Pools. |
| <a name="output_wwpn_pools"></a> [wwpn\_pools](#output\_wwpn\_pools) | Moid of the WWPN Pools. |
## Resources

No resources.
<!-- END_TF_DOCS -->