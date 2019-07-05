#### Assignment 8
1. Split the creation
2. Makefile
3. Remote state

```
cd networking/
export AWS_DEFAULT_REGION='us-east-1' - for remote state file backend conf(s3 region)
make init
make plan
make apply
make destroy
```

```
cd compute/
export AWS_DEFAULT_REGION='us-east-1' - for remote state file backend conf(s3 region)
make init
make plan
make apply
make destroy
```
