Terraform is tool that allows you to <span class="gold">provision</span> infrastructure

+++

It supports many cloud service providers

- AWS
- Google Cloud
- Heroku
- CloudFlare

+++ 

and allows you to create <span class="gold">resources</span> for each provider

+++

You provision infrastructure by writing terraform <span class="gold">templates</span>

+++

```json
provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "example" {
    ami = "ami=abcdef12"
    instance_type = "t2.medium"
}
```

This template creates an EC2 instance

+++

![docker-logo](assets/images/code-in-infrastructure-out.png)
