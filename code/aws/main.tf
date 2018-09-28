
provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "example" {
    count = 2 
    ami = "ami-047bb4163c506cd98" 
    instance_type = "t2.small"
    key_name = "test"
    user_data = <<EOF
                #!/bin/bash
                sudo yum install -y docker
                sudo service docker start
                sudo docker run -p 8000:8000 -d momirza/cowsayer:0.1.0
                EOF

}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

data "aws_route53_zone" "zone" {
  name = "cowoca.com."
}

resource "aws_route53_record" "root" {
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  name    = "cowoca.com"
  type    = "A"

  alias {
    name                   = "${aws_elb.example.dns_name}"
    zone_id                = "${aws_elb.example.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_elb" "example" {
    name = "cowsayer-elb"
    availability_zones = ["${aws_instance.example.*.availability_zone}"]
    instances = ["${aws_instance.example.*.id}"]
    security_groups = ["${aws_security_group.allow_all.id}"]
    idle_timeout = 5
    listener {
        lb_protocol = "http"
        lb_port = 80
        # ssl_certificate_id = "${aws_acm_certificate_validation.cert.certificate_arn}"
        instance_port = 8000
        instance_protocol = "http"
    }
    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 10
        interval = 20
        target = "HTTP:8000/health_check"
    }
}

# Run:
# $ terraform graph
# Visualise here:
# http://dreampuf.github.io/GraphvizOnline/



# Uncomment the following lines to enable https!
# Don't forget to update the elb listener above

# resource "aws_acm_certificate" "cert" {
#   domain_name = "cowoca.com"
#   validation_method = "DNS"
# }

# resource "aws_route53_record" "cert_validation" {
#   name = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
#   type = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_type}"
#   zone_id = "${data.aws_route53_zone.zone.id}"
#   records = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]
#   ttl = 60
# }

# resource "aws_acm_certificate_validation" "cert" {
#   certificate_arn = "${aws_acm_certificate.cert.arn}"
#   validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
# }