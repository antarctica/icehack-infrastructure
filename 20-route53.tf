#
# BAS Icehack AWS Route53 (DNS) Terraform resource configuration
# This file is used to define the Route53 (DNS) resources used to contain all DNS records for resources used by BAS in
# AWS, such as EC2 instances, for the Icehack event.
#
# Source: https://aws.amazon.com/route53/
#
# As DNS is hierarchical, multiple, nested, resources are used to configure the DNS hierarchy used by BAS in AWS.
# These resources are all configured in this file.
#
# This file relies on the AWS Terraform provider being previously configured.

# AWS Route53 zone types
# There are two zone types: Public and Private.
# Public Zones are can be resolved from the Internet, but records may still resolve to private IPs for example
# Private Zones are associated with, and can only be resolved from within, a VPC, providing VPC DNS servers are used

# Public zone delegated from the BAS DNS maintained by BAS ICT
# This sub-domain is used to provide friendlier access to Virtual Environments
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/AboutHZWorkingWith.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_zone.html
resource "aws_route53_zone" "Icehack" {
    name = "icehack.bas.ac.uk"
    comment = "Provides glamour DNS records for Icehack related resources"

    tags {
        Name = "icehack.bas.ac.uk"
        X-Managed-By = "Terraform"
    }
}
