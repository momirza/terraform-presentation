
Deploy an EC2 cluster behind a load balancer

+++
![infra](assets/images/demo-infra.png)

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
"aws_elb.elb": {
                    "type": "aws_elb",
                    "depends_on": [
                        "aws_instance.instance.*",
                    ],
                    "primary": {
                        "id": "elb",
                        "attributes": {
                            "access_logs.#": "0",
                            ...
                        }
                    }
}
```