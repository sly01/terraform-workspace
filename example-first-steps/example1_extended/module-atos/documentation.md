## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| dns\_creation | Enable dns creation or not | bool | n/a | yes |
| domain\_name | Domain name like: aerkoc, merkoc | string | n/a | yes |
| environment | Environment value | string | n/a | yes |
| instance\_count | Number of instances | string | `"2"` | no |
| region | Region | string | n/a | yes |
| sg\_description |  | string | `"asdfasdfasd desc"` | no |
| web\_port | Your web server port | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| elb\_public\_dns\_name |  |

