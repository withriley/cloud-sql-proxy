# Usage
<!--- BEGIN_TF_DOCS --->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_ports | Additional ports to open for IAP tunnelling - only used if create\_firewall\_rule is true | `list(string)` | `[]` | no |
| create\_firewall\_rule | Boolean to enable/disable firewall rule creation for IAP tunnelling | `bool` | `false` | no |
| db\_name | Cloud SQL instance database name | `string` | n/a | yes |
| host\_project | Project where the firewall rule will be created if using Shared VPC - if not using Shared VPC leave blank | `string` | `""` | no |
| members | List of the members to grant IAM permissions for IAP tunnelling | `list(string)` | n/a | yes |
| network | Name of the network/VPC | `string` | n/a | yes |
| project | Project name to deploy the resources to | `string` | n/a | yes |
| region | Region to deploy the resources to | `string` | n/a | yes |
| subnetwork | Name of the subnetwork | `string` | n/a | yes |

## Outputs

No output.

<!--- END_TF_DOCS --->
