#### Single Web Server

1. Create ubuntu instance, t2.micro, put userdata which will execute;

```
#!/bin/bash
echo "Hello, World" > index.html
nohup busybox httpd -f -p 8080 &
```

2. Create security group and attach to instance

3. Output is supposed to be publip_ip or public_dns of instance
