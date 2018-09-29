provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "instance" {
    count = "${var.instance_count}"
    ami = "ami-047bb4163c506cd98" 
    instance_type = "t2.small"
    user_data = <<EOF
    #!/bin/bash
    sudo yum install -y docker
    sudo service docker start
    sudo docker run -p ${var.instance_port}:${var.container_port} -d ${var.image}:${var.image_version}
    EOF

}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all traffic"

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
  name = "${var.domain_name}"
}

resource "aws_route53_record" "root" {
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  name    = "${var.domain_name}"
  type    = "A"

  alias {
    name                   = "${aws_elb.elb.dns_name}"
    zone_id                = "${aws_elb.elb.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_elb" "elb" {
    availability_zones = ["${aws_instance.instance.*.availability_zone}"]
    instances = ["${aws_instance.instance.*.id}"]
    security_groups = ["${aws_security_group.allow_all.id}"]
    
    idle_timeout = 5
    listener {
        lb_protocol = "${var.load_balancer_protocol}"
        lb_port = "${lookup(var.load_balancer_port, var.load_balancer_protocol)}"
        # ssl_certificate_id = "${aws_acm_certificate_validation.cert.certificate_arn}"
        instance_port = "${var.instance_port}"
        instance_protocol = "${var.instance_protocol}"
    }
    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 10
        interval = 20
        target = "HTTP:${var.instance_port}/${var.health_check_path}"
    }
}

# Run:
# $ terraform graph
# Visualise here:
# http://www.webgraphviz.com



# Uncomment the following lines to enable https!
# Don't forget to update the elb listener protocol in vars.tf 
# and uncomment the ssl_certificate_id

# resource "aws_acm_certificate" "cert" {
#     domain_name = "${var.domain_name}"
#     validation_method = "DNS"
# }

# resource "aws_route53_record" "cert_validation" {
#     name = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
#     type = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_type}"
#     zone_id = "${data.aws_route53_zone.zone.id}"
#     records = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]
#     ttl = 60
# }

# resource "aws_acm_certificate_validation" "cert" {
#   certificate_arn = "${aws_acm_certificate.cert.arn}"
#   validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
# }