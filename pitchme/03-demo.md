
Deploy an EC2 cluster behind a load balancer

+++
![infra](assets/images/demo-infra.png)

+++

```
                        ^__^
                        (oo)\_______
                        (__)\       )\/\
                            ||----w |
                            ||     ||

```

https://hub.docker.com/r/momirza/cowsayer/

+++

Variables

```json
variable "domain_name" {
    default = "cowoca.com"
}
```

+++

Dependency graphs

![dependency-graph](assets/images/dependency-graph.png)

+++

State

```json
"aws_instance.instance.0": {
                    "type": "aws_instance",
                    "depends_on": [],
                    "primary": {
                        "id": "i-0542caf31848033e6",
                        "attributes": {
                            "ami": "ami-047bb4163c506cd98",
                            ...
                        }
                    }
}
```

+++

```ascii
├── aws/
│   ├── main.tf
│   ├── vars.tf
│   └── terraform.tfstate
```