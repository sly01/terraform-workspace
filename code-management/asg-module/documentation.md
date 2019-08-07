## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| delegation\_set | Route53 delegation set | string | n/a | yes |
| dns\_zone\_creation | DNS Zone Creation | string | n/a | yes |
| domain\_name | Domain name which is given by tk | string | n/a | yes |
| environment | Environment(dev, prod, nonprod) | string | n/a | yes |
| instance\_type | Flavor(t2.micro ...) | string | n/a | yes |
| max\_size | Number of max instance for asg | string | n/a | yes |
| min\_size | Number of min instance for asg | string | `"2"` | no |
| region | AWS Region(us-east-1, eu-central-1 ...) | string | n/a | yes |
| web\_port | Web access port for instances | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| elb\_public\_dns |  |

