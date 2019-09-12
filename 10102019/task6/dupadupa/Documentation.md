## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| delegation\_set | Delegation set for Route53 | string | n/a | yes |
| dns\_zone\_creation | Dns zone creation decision | bool | n/a | yes |
| domain\_name | Domain name | string | n/a | yes |
| env | environment | string | n/a | yes |
| instance\_type | Flavor -> t2.micro, t2.small | string | `"t2.micro"` | no |
| max\_size | Max number of instances | number | n/a | yes |
| min\_size | Min number of instances | number | `"2"` | no |
| region |  | string | n/a | yes |
| web\_port |  | number | `"8080"` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_elb\_public\_dns |  |

