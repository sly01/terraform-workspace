## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| delegation\_set | Delegation set for reusable route53 | string | n/a | yes |
| dns\_zone\_creation | Dns creation true/false | string | n/a | yes |
| domain\_name | Domain name from tk | string | n/a | yes |
| env | Environment such as dev, prod, nonprod, stage | string | n/a | yes |
| instance\_type | Flavor of machine t2.micro, t2.small, etc... | string | `"t2.micro"` | no |
| max\_size | Max size for ASG | string | n/a | yes |
| min\_size | Min size for ASG | string | `"2"` | no |
| region | Region eu-central-1, us-east-1 | string | n/a | yes |
| web\_port | Web port 8080, 80, 9090 | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| elb\_dns |  |

