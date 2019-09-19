## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| delegation\_set | delegation set for route53 | string | n/a | yes |
| dns\_zone\_creation | Create dns zone or use existing | string | n/a | yes |
| domain\_name | domain name end with tk | string | n/a | yes |
| env | Environment dev,prod,nonprod whatever.... | string | n/a | yes |
| instance\_count | Number of instances | string | n/a | yes |
| instance\_size | Flavor t2.micro, t2.small | string | n/a | yes |
| max\_size | max size for asg | string | n/a | yes |
| min\_size | min size for asg | string | n/a | yes |
| region | Region of aws eu-central-1,us-east-1 | string | `"eu-central-1"` | no |
| web\_port | web port 79,8080,9999,1111 | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| elb\_public\_dns |  |

