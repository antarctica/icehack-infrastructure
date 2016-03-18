#
# BAS Icehack AWS Elastic Compute Cloud (EC2) Terraform resource configuration
# This file is used to define EC2 instances for production

#
# These nodes are primary production nodes - for use by participants
#

# Virtual Environment VM - Accessible worldwide
#
# This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# This resource implicitly depends on the 'aws_security_group.all-egress' resource
# This resource implicitly depends on the 'aws_security_group.ping' resource
# This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# This resource implicitly depends on the 'aws_security_group.http-world' resource
# This resource implicitly depends on the 'aws_security_group.https-world' resource
#
# AWS source: https://aws.amazon.com/ec2/
# Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "icehack-prod-node1" {
    instance_type = "t2.micro"
    ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
    key_name = "${var.aws_ssh_key}"

    subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
    vpc_security_group_ids = [
        "${aws_security_group.all-egress.id}",
        "${aws_security_group.ping.id}",
        "${aws_security_group.ssh-world.id}",
        "${aws_security_group.http-world.id}",
        "${aws_security_group.https-world.id}"
    ]

    tags {
        Name = "icehack-prod-node1"
        X-Project = "Icehack"
        X-Purpose = "Node"
        X-Subnet = "External"
        X-Managed-By = "Terraform"
    }
}

# This resource implicitly depends on the 'aws_instance.icehack-prod-node1' resource
#
# AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
#
# Tags are not supported by this resource
resource "aws_eip" "icehack-prod-node1" {
    instance = "${aws_instance.icehack-prod-node1.id}"
    vpc = true
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node1' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-prod-node1" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "icehack-prod-node1"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node1.public_ip}"
    ]
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node1' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-node1" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "node1"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node1.public_ip}"
    ]
}

# Virtual Environment VM - Accessible worldwide
#
# This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# This resource implicitly depends on the 'aws_security_group.all-egress' resource
# This resource implicitly depends on the 'aws_security_group.ping' resource
# This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# This resource implicitly depends on the 'aws_security_group.http-world' resource
# This resource implicitly depends on the 'aws_security_group.https-world' resource
#
# AWS source: https://aws.amazon.com/ec2/
# Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "icehack-prod-node2" {
    instance_type = "t2.micro"
    ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
    key_name = "${var.aws_ssh_key}"

    subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
    vpc_security_group_ids = [
        "${aws_security_group.all-egress.id}",
        "${aws_security_group.ping.id}",
        "${aws_security_group.ssh-world.id}",
        "${aws_security_group.http-world.id}",
        "${aws_security_group.https-world.id}"
    ]

    tags {
        Name = "icehack-prod-node2"
        X-Project = "Icehack"
        X-Purpose = "Node"
        X-Subnet = "External"
        X-Managed-By = "Terraform"
    }
}

# This resource implicitly depends on the 'aws_instance.icehack-prod-node2' resource
#
# AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
#
# Tags are not supported by this resource
resource "aws_eip" "icehack-prod-node2" {
    instance = "${aws_instance.icehack-prod-node2.id}"
    vpc = true
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node2' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-prod-node2" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "icehack-prod-node2"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node2.public_ip}"
    ]
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node2' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-node2" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "node2"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node2.public_ip}"
    ]
}

# Virtual Environment VM - Accessible worldwide
#
# This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# This resource implicitly depends on the 'aws_security_group.all-egress' resource
# This resource implicitly depends on the 'aws_security_group.ping' resource
# This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# This resource implicitly depends on the 'aws_security_group.http-world' resource
# This resource implicitly depends on the 'aws_security_group.https-world' resource
#
# AWS source: https://aws.amazon.com/ec2/
# Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "icehack-prod-node3" {
    instance_type = "t2.micro"
    ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
    key_name = "${var.aws_ssh_key}"

    subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
    vpc_security_group_ids = [
        "${aws_security_group.all-egress.id}",
        "${aws_security_group.ping.id}",
        "${aws_security_group.ssh-world.id}",
        "${aws_security_group.http-world.id}",
        "${aws_security_group.https-world.id}"
    ]

    tags {
        Name = "icehack-prod-node3"
        X-Project = "Icehack"
        X-Purpose = "Node"
        X-Subnet = "External"
        X-Managed-By = "Terraform"
    }
}

# This resource implicitly depends on the 'aws_instance.icehack-prod-node3' resource
#
# AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
#
# Tags are not supported by this resource
resource "aws_eip" "icehack-prod-node3" {
    instance = "${aws_instance.icehack-prod-node3.id}"
    vpc = true
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node3' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-prod-node3" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "icehack-prod-node3"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node3.public_ip}"
    ]
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node3' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-node3" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "node3"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node3.public_ip}"
    ]
}

# Virtual Environment VM - Accessible worldwide
#
# This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# This resource implicitly depends on the 'aws_security_group.all-egress' resource
# This resource implicitly depends on the 'aws_security_group.ping' resource
# This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# This resource implicitly depends on the 'aws_security_group.http-world' resource
# This resource implicitly depends on the 'aws_security_group.https-world' resource
#
# AWS source: https://aws.amazon.com/ec2/
# Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "icehack-prod-node4" {
    instance_type = "t2.micro"
    ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
    key_name = "${var.aws_ssh_key}"

    subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
    vpc_security_group_ids = [
        "${aws_security_group.all-egress.id}",
        "${aws_security_group.ping.id}",
        "${aws_security_group.ssh-world.id}",
        "${aws_security_group.http-world.id}",
        "${aws_security_group.https-world.id}"
    ]

    tags {
        Name = "icehack-prod-node4"
        X-Project = "Icehack"
        X-Purpose = "Node"
        X-Subnet = "External"
        X-Managed-By = "Terraform"
    }
}

# This resource implicitly depends on the 'aws_instance.icehack-prod-node4' resource
#
# AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
#
# Tags are not supported by this resource
resource "aws_eip" "icehack-prod-node4" {
    instance = "${aws_instance.icehack-prod-node4.id}"
    vpc = true
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node4' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-prod-node4" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "icehack-prod-node4"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node4.public_ip}"
    ]
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node4' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-node4" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "node4"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node4.public_ip}"
    ]
}

# Virtual Environment VM - Accessible worldwide
#
# This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# This resource implicitly depends on the 'aws_security_group.all-egress' resource
# This resource implicitly depends on the 'aws_security_group.ping' resource
# This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# This resource implicitly depends on the 'aws_security_group.http-world' resource
# This resource implicitly depends on the 'aws_security_group.https-world' resource
#
# AWS source: https://aws.amazon.com/ec2/
# Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "icehack-prod-node5" {
    instance_type = "t2.micro"
    ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
    key_name = "${var.aws_ssh_key}"

    subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
    vpc_security_group_ids = [
        "${aws_security_group.all-egress.id}",
        "${aws_security_group.ping.id}",
        "${aws_security_group.ssh-world.id}",
        "${aws_security_group.http-world.id}",
        "${aws_security_group.https-world.id}"
    ]

    tags {
        Name = "icehack-prod-node5"
        X-Project = "Icehack"
        X-Purpose = "Node"
        X-Subnet = "External"
        X-Managed-By = "Terraform"
    }
}

# This resource implicitly depends on the 'aws_instance.icehack-prod-node5' resource
#
# AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
#
# Tags are not supported by this resource
resource "aws_eip" "icehack-prod-node5" {
    instance = "${aws_instance.icehack-prod-node5.id}"
    vpc = true
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node5' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-prod-node5" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "icehack-prod-node5"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node5.public_ip}"
    ]
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node5' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-node5" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "node5"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node5.public_ip}"
    ]
}

# Virtual Environment VM - Accessible worldwide
#
# This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# This resource implicitly depends on the 'aws_security_group.all-egress' resource
# This resource implicitly depends on the 'aws_security_group.ping' resource
# This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# This resource implicitly depends on the 'aws_security_group.http-world' resource
# This resource implicitly depends on the 'aws_security_group.https-world' resource
#
# AWS source: https://aws.amazon.com/ec2/
# Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "icehack-prod-node6" {
    instance_type = "t2.micro"
    ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
    key_name = "${var.aws_ssh_key}"

    subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
    vpc_security_group_ids = [
        "${aws_security_group.all-egress.id}",
        "${aws_security_group.ping.id}",
        "${aws_security_group.ssh-world.id}",
        "${aws_security_group.http-world.id}",
        "${aws_security_group.https-world.id}"
    ]

    tags {
        Name = "icehack-prod-node6"
        X-Project = "Icehack"
        X-Purpose = "Node"
        X-Subnet = "External"
        X-Managed-By = "Terraform"
    }
}

# This resource implicitly depends on the 'aws_instance.icehack-prod-node6' resource
#
# AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
#
# Tags are not supported by this resource
resource "aws_eip" "icehack-prod-node6" {
    instance = "${aws_instance.icehack-prod-node6.id}"
    vpc = true
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node6' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-prod-node6" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "icehack-prod-node6"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node6.public_ip}"
    ]
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node6' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-node6" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "node6"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node6.public_ip}"
    ]
}

# Virtual Environment VM - Accessible worldwide
#
# This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# This resource implicitly depends on the 'aws_security_group.all-egress' resource
# This resource implicitly depends on the 'aws_security_group.ping' resource
# This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# This resource implicitly depends on the 'aws_security_group.http-world' resource
# This resource implicitly depends on the 'aws_security_group.https-world' resource
#
# AWS source: https://aws.amazon.com/ec2/
# Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "icehack-prod-node7" {
    instance_type = "t2.micro"
    ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
    key_name = "${var.aws_ssh_key}"

    subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
    vpc_security_group_ids = [
        "${aws_security_group.all-egress.id}",
        "${aws_security_group.ping.id}",
        "${aws_security_group.ssh-world.id}",
        "${aws_security_group.http-world.id}",
        "${aws_security_group.https-world.id}"
    ]

    tags {
        Name = "icehack-prod-node7"
        X-Project = "Icehack"
        X-Purpose = "Node"
        X-Subnet = "External"
        X-Managed-By = "Terraform"
    }
}

# This resource implicitly depends on the 'aws_instance.icehack-prod-node7' resource
#
# AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
#
# Tags are not supported by this resource
resource "aws_eip" "icehack-prod-node7" {
    instance = "${aws_instance.icehack-prod-node7.id}"
    vpc = true
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node7' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-prod-node7" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "icehack-prod-node7"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node7.public_ip}"
    ]
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node7' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-node7" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "node7"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node7.public_ip}"
    ]
}

# Virtual Environment VM - Accessible worldwide
#
# This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# This resource implicitly depends on the 'aws_security_group.all-egress' resource
# This resource implicitly depends on the 'aws_security_group.ping' resource
# This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# This resource implicitly depends on the 'aws_security_group.http-world' resource
# This resource implicitly depends on the 'aws_security_group.https-world' resource
#
# AWS source: https://aws.amazon.com/ec2/
# Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "icehack-prod-node8" {
    instance_type = "t2.micro"
    ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
    key_name = "${var.aws_ssh_key}"

    subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
    vpc_security_group_ids = [
        "${aws_security_group.all-egress.id}",
        "${aws_security_group.ping.id}",
        "${aws_security_group.ssh-world.id}",
        "${aws_security_group.http-world.id}",
        "${aws_security_group.https-world.id}"
    ]

    tags {
        Name = "icehack-prod-node8"
        X-Project = "Icehack"
        X-Purpose = "Node"
        X-Subnet = "External"
        X-Managed-By = "Terraform"
    }
}

# This resource implicitly depends on the 'aws_instance.icehack-prod-node8' resource
#
# AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
#
# Tags are not supported by this resource
resource "aws_eip" "icehack-prod-node8" {
    instance = "${aws_instance.icehack-prod-node8.id}"
    vpc = true
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node8' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-prod-node8" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "icehack-prod-node8"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node8.public_ip}"
    ]
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node8' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-node8" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "node8"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node8.public_ip}"
    ]
}

# Virtual Environment VM - Accessible worldwide
#
# This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# This resource implicitly depends on the 'aws_security_group.all-egress' resource
# This resource implicitly depends on the 'aws_security_group.ping' resource
# This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# This resource implicitly depends on the 'aws_security_group.http-world' resource
# This resource implicitly depends on the 'aws_security_group.https-world' resource
#
# AWS source: https://aws.amazon.com/ec2/
# Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "icehack-prod-node9" {
    instance_type = "t2.micro"
    ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
    key_name = "${var.aws_ssh_key}"

    subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
    vpc_security_group_ids = [
        "${aws_security_group.all-egress.id}",
        "${aws_security_group.ping.id}",
        "${aws_security_group.ssh-world.id}",
        "${aws_security_group.http-world.id}",
        "${aws_security_group.https-world.id}"
    ]

    tags {
        Name = "icehack-prod-node9"
        X-Project = "Icehack"
        X-Purpose = "Node"
        X-Subnet = "External"
        X-Managed-By = "Terraform"
    }
}

# This resource implicitly depends on the 'aws_instance.icehack-prod-node9' resource
#
# AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
#
# Tags are not supported by this resource
resource "aws_eip" "icehack-prod-node9" {
    instance = "${aws_instance.icehack-prod-node9.id}"
    vpc = true
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node9' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-prod-node9" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "icehack-prod-node9"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node9.public_ip}"
    ]
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node9' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-node9" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "node9"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node9.public_ip}"
    ]
}

# Virtual Environment VM - Accessible worldwide
#
# This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# This resource implicitly depends on the 'aws_security_group.all-egress' resource
# This resource implicitly depends on the 'aws_security_group.ping' resource
# This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# This resource implicitly depends on the 'aws_security_group.http-world' resource
# This resource implicitly depends on the 'aws_security_group.https-world' resource
#
# AWS source: https://aws.amazon.com/ec2/
# Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "icehack-prod-node10" {
    instance_type = "t2.micro"
    ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
    key_name = "${var.aws_ssh_key}"

    subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
    vpc_security_group_ids = [
        "${aws_security_group.all-egress.id}",
        "${aws_security_group.ping.id}",
        "${aws_security_group.ssh-world.id}",
        "${aws_security_group.http-world.id}",
        "${aws_security_group.https-world.id}"
    ]

    tags {
        Name = "icehack-prod-node10"
        X-Project = "Icehack"
        X-Purpose = "Node"
        X-Subnet = "External"
        X-Managed-By = "Terraform"
    }
}

# This resource implicitly depends on the 'aws_instance.icehack-prod-node10' resource
#
# AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
#
# Tags are not supported by this resource
resource "aws_eip" "icehack-prod-node10" {
    instance = "${aws_instance.icehack-prod-node10.id}"
    vpc = true
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node10' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-prod-node10" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "icehack-prod-node10"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node10.public_ip}"
    ]
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node10' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-node10" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "node10"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node10.public_ip}"
    ]
}

# # Virtual Environment VM - Accessible worldwide
# #
# # This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# # This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# # This resource implicitly depends on the 'aws_security_group.all-egress' resource
# # This resource implicitly depends on the 'aws_security_group.ping' resource
# # This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# # This resource implicitly depends on the 'aws_security_group.http-world' resource
# # This resource implicitly depends on the 'aws_security_group.https-world' resource
# #
# # AWS source: https://aws.amazon.com/ec2/
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
# resource "aws_instance" "icehack-prod-node11" {
#     instance_type = "t2.micro"
#     ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
#     key_name = "${var.aws_ssh_key}"

#     subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
#     vpc_security_group_ids = [
#         "${aws_security_group.all-egress.id}",
#         "${aws_security_group.ping.id}",
#         "${aws_security_group.ssh-world.id}",
#         "${aws_security_group.http-world.id}",
#         "${aws_security_group.https-world.id}"
#     ]

#     tags {
#         Name = "icehack-prod-node11"
#         X-Project = "Icehack"
#         X-Purpose = "Node"
#         X-Subnet = "External"
#         X-Managed-By = "Terraform"
#     }
# }

# # This resource implicitly depends on the 'aws_instance.icehack-prod-node11' resource
# #
# # AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
# #
# # Tags are not supported by this resource
# resource "aws_eip" "icehack-prod-node11" {
#     instance = "${aws_instance.icehack-prod-node11.id}"
#     vpc = true
# }

# # This resource implicitly depends on the 'aws_eip.icehack-prod-node11' resource
# # This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
# #
# # AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
# #
# # Tags are not supported by this resource
# resource "aws_route53_record" "icehack-prod-node11" {
#     zone_id = "${aws_route53_zone.Icehack.id}"

#     name = "icehack-prod-node11"
#     type = "A"
#     ttl = "300"
#     records = [
#         "${aws_eip.icehack-prod-node11.public_ip}"
#     ]
# }

# # This resource implicitly depends on the 'aws_eip.icehack-prod-node11' resource
# # This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
# #
# # AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
# #
# # Tags are not supported by this resource
# resource "aws_route53_record" "icehack-node11" {
#     zone_id = "${aws_route53_zone.Icehack.id}"

#     name = "node11"
#     type = "A"
#     ttl = "300"
#     records = [
#         "${aws_eip.icehack-prod-node11.public_ip}"
#     ]
# }

# # Virtual Environment VM - Accessible worldwide
# #
# # This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# # This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# # This resource implicitly depends on the 'aws_security_group.all-egress' resource
# # This resource implicitly depends on the 'aws_security_group.ping' resource
# # This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# # This resource implicitly depends on the 'aws_security_group.http-world' resource
# # This resource implicitly depends on the 'aws_security_group.https-world' resource
# #
# # AWS source: https://aws.amazon.com/ec2/
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
# resource "aws_instance" "icehack-prod-node12" {
#     instance_type = "t2.micro"
#     ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
#     key_name = "${var.aws_ssh_key}"

#     subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
#     vpc_security_group_ids = [
#         "${aws_security_group.all-egress.id}",
#         "${aws_security_group.ping.id}",
#         "${aws_security_group.ssh-world.id}",
#         "${aws_security_group.http-world.id}",
#         "${aws_security_group.https-world.id}"
#     ]

#     tags {
#         Name = "icehack-prod-node12"
#         X-Project = "Icehack"
#         X-Purpose = "Node"
#         X-Subnet = "External"
#         X-Managed-By = "Terraform"
#     }
# }

# # This resource implicitly depends on the 'aws_instance.icehack-prod-node12' resource
# #
# # AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
# #
# # Tags are not supported by this resource
# resource "aws_eip" "icehack-prod-node12" {
#     instance = "${aws_instance.icehack-prod-node12.id}"
#     vpc = true
# }

# # This resource implicitly depends on the 'aws_eip.icehack-prod-node12' resource
# # This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
# #
# # AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
# #
# # Tags are not supported by this resource
# resource "aws_route53_record" "icehack-prod-node12" {
#     zone_id = "${aws_route53_zone.Icehack.id}"

#     name = "icehack-prod-node12"
#     type = "A"
#     ttl = "300"
#     records = [
#         "${aws_eip.icehack-prod-node12.public_ip}"
#     ]
# }

# # This resource implicitly depends on the 'aws_eip.icehack-prod-node12' resource
# # This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
# #
# # AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
# #
# # Tags are not supported by this resource
# resource "aws_route53_record" "icehack-node12" {
#     zone_id = "${aws_route53_zone.Icehack.id}"

#     name = "node12"
#     type = "A"
#     ttl = "300"
#     records = [
#         "${aws_eip.icehack-prod-node12.public_ip}"
#     ]
# }

# # Virtual Environment VM - Accessible worldwide
# #
# # This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# # This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# # This resource implicitly depends on the 'aws_security_group.all-egress' resource
# # This resource implicitly depends on the 'aws_security_group.ping' resource
# # This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# # This resource implicitly depends on the 'aws_security_group.http-world' resource
# # This resource implicitly depends on the 'aws_security_group.https-world' resource
# #
# # AWS source: https://aws.amazon.com/ec2/
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
# resource "aws_instance" "icehack-prod-node13" {
#     instance_type = "t2.micro"
#     ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
#     key_name = "${var.aws_ssh_key}"

#     subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
#     vpc_security_group_ids = [
#         "${aws_security_group.all-egress.id}",
#         "${aws_security_group.ping.id}",
#         "${aws_security_group.ssh-world.id}",
#         "${aws_security_group.http-world.id}",
#         "${aws_security_group.https-world.id}"
#     ]

#     tags {
#         Name = "icehack-prod-node13"
#         X-Project = "Icehack"
#         X-Purpose = "Node"
#         X-Subnet = "External"
#         X-Managed-By = "Terraform"
#     }
# }

# # This resource implicitly depends on the 'aws_instance.icehack-prod-node13' resource
# #
# # AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
# #
# # Tags are not supported by this resource
# resource "aws_eip" "icehack-prod-node13" {
#     instance = "${aws_instance.icehack-prod-node13.id}"
#     vpc = true
# }

# # This resource implicitly depends on the 'aws_eip.icehack-prod-node13' resource
# # This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
# #
# # AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
# #
# # Tags are not supported by this resource
# resource "aws_route53_record" "icehack-prod-node13" {
#     zone_id = "${aws_route53_zone.Icehack.id}"

#     name = "icehack-prod-node13"
#     type = "A"
#     ttl = "300"
#     records = [
#         "${aws_eip.icehack-prod-node13.public_ip}"
#     ]
# }

# # This resource implicitly depends on the 'aws_eip.icehack-prod-node13' resource
# # This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
# #
# # AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
# #
# # Tags are not supported by this resource
# resource "aws_route53_record" "icehack-node13" {
#     zone_id = "${aws_route53_zone.Icehack.id}"

#     name = "node13"
#     type = "A"
#     ttl = "300"
#     records = [
#         "${aws_eip.icehack-prod-node13.public_ip}"
#     ]
# }

# # Virtual Environment VM - Accessible worldwide
# #
# # This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# # This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# # This resource implicitly depends on the 'aws_security_group.all-egress' resource
# # This resource implicitly depends on the 'aws_security_group.ping' resource
# # This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# # This resource implicitly depends on the 'aws_security_group.http-world' resource
# # This resource implicitly depends on the 'aws_security_group.https-world' resource
# #
# # AWS source: https://aws.amazon.com/ec2/
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
# resource "aws_instance" "icehack-prod-node14" {
#     instance_type = "t2.micro"
#     ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
#     key_name = "${var.aws_ssh_key}"

#     subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
#     vpc_security_group_ids = [
#         "${aws_security_group.all-egress.id}",
#         "${aws_security_group.ping.id}",
#         "${aws_security_group.ssh-world.id}",
#         "${aws_security_group.http-world.id}",
#         "${aws_security_group.https-world.id}"
#     ]

#     tags {
#         Name = "icehack-prod-node14"
#         X-Project = "Icehack"
#         X-Purpose = "Node"
#         X-Subnet = "External"
#         X-Managed-By = "Terraform"
#     }
# }

# # This resource implicitly depends on the 'aws_instance.icehack-prod-node14' resource
# #
# # AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
# #
# # Tags are not supported by this resource
# resource "aws_eip" "icehack-prod-node14" {
#     instance = "${aws_instance.icehack-prod-node14.id}"
#     vpc = true
# }

# # This resource implicitly depends on the 'aws_eip.icehack-prod-node14' resource
# # This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
# #
# # AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
# #
# # Tags are not supported by this resource
# resource "aws_route53_record" "icehack-prod-node14" {
#     zone_id = "${aws_route53_zone.Icehack.id}"

#     name = "icehack-prod-node14"
#     type = "A"
#     ttl = "300"
#     records = [
#         "${aws_eip.icehack-prod-node14.public_ip}"
#     ]
# }

# # This resource implicitly depends on the 'aws_eip.icehack-prod-node14' resource
# # This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
# #
# # AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
# #
# # Tags are not supported by this resource
# resource "aws_route53_record" "icehack-node14" {
#     zone_id = "${aws_route53_zone.Icehack.id}"

#     name = "node14"
#     type = "A"
#     ttl = "300"
#     records = [
#         "${aws_eip.icehack-prod-node14.public_ip}"
#     ]
# }

# # Virtual Environment VM - Accessible worldwide
# #
# # This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# # This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# # This resource implicitly depends on the 'aws_security_group.all-egress' resource
# # This resource implicitly depends on the 'aws_security_group.ping' resource
# # This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# # This resource implicitly depends on the 'aws_security_group.http-world' resource
# # This resource implicitly depends on the 'aws_security_group.https-world' resource
# #
# # AWS source: https://aws.amazon.com/ec2/
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
# resource "aws_instance" "icehack-prod-node15" {
#     instance_type = "t2.micro"
#     ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
#     key_name = "${var.aws_ssh_key}"

#     subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
#     vpc_security_group_ids = [
#         "${aws_security_group.all-egress.id}",
#         "${aws_security_group.ping.id}",
#         "${aws_security_group.ssh-world.id}",
#         "${aws_security_group.http-world.id}",
#         "${aws_security_group.https-world.id}"
#     ]

#     tags {
#         Name = "icehack-prod-node15"
#         X-Project = "Icehack"
#         X-Purpose = "Node"
#         X-Subnet = "External"
#         X-Managed-By = "Terraform"
#     }
# }

# # This resource implicitly depends on the 'aws_instance.icehack-prod-node15' resource
# #
# # AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
# #
# # Tags are not supported by this resource
# resource "aws_eip" "icehack-prod-node15" {
#     instance = "${aws_instance.icehack-prod-node15.id}"
#     vpc = true
# }

# # This resource implicitly depends on the 'aws_eip.icehack-prod-node15' resource
# # This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
# #
# # AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
# #
# # Tags are not supported by this resource
# resource "aws_route53_record" "icehack-prod-node15" {
#     zone_id = "${aws_route53_zone.Icehack.id}"

#     name = "icehack-prod-node15"
#     type = "A"
#     ttl = "300"
#     records = [
#         "${aws_eip.icehack-prod-node15.public_ip}"
#     ]
# }

# # This resource implicitly depends on the 'aws_eip.icehack-prod-node15' resource
# # This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
# #
# # AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
# #
# # Tags are not supported by this resource
# resource "aws_route53_record" "icehack-node15" {
#     zone_id = "${aws_route53_zone.Icehack.id}"

#     name = "node15"
#     type = "A"
#     ttl = "300"
#     records = [
#         "${aws_eip.icehack-prod-node15.public_ip}"
#     ]
# }

# # Virtual Environment VM - Accessible worldwide
# #
# # This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# # This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# # This resource implicitly depends on the 'aws_security_group.all-egress' resource
# # This resource implicitly depends on the 'aws_security_group.ping' resource
# # This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# # This resource implicitly depends on the 'aws_security_group.http-world' resource
# # This resource implicitly depends on the 'aws_security_group.https-world' resource
# #
# # AWS source: https://aws.amazon.com/ec2/
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
# resource "aws_instance" "icehack-prod-node16" {
#     instance_type = "t2.micro"
#     ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
#     key_name = "${var.aws_ssh_key}"

#     subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
#     vpc_security_group_ids = [
#         "${aws_security_group.all-egress.id}",
#         "${aws_security_group.ping.id}",
#         "${aws_security_group.ssh-world.id}",
#         "${aws_security_group.http-world.id}",
#         "${aws_security_group.https-world.id}"
#     ]

#     tags {
#         Name = "icehack-prod-node16"
#         X-Project = "Icehack"
#         X-Purpose = "Node"
#         X-Subnet = "External"
#         X-Managed-By = "Terraform"
#     }
# }

# # This resource implicitly depends on the 'aws_instance.icehack-prod-node16' resource
# #
# # AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
# #
# # Tags are not supported by this resource
# resource "aws_eip" "icehack-prod-node16" {
#     instance = "${aws_instance.icehack-prod-node16.id}"
#     vpc = true
# }

# # This resource implicitly depends on the 'aws_eip.icehack-prod-node16' resource
# # This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
# #
# # AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
# #
# # Tags are not supported by this resource
# resource "aws_route53_record" "icehack-prod-node16" {
#     zone_id = "${aws_route53_zone.Icehack.id}"

#     name = "icehack-prod-node16"
#     type = "A"
#     ttl = "300"
#     records = [
#         "${aws_eip.icehack-prod-node16.public_ip}"
#     ]
# }

# # This resource implicitly depends on the 'aws_eip.icehack-prod-node16' resource
# # This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
# #
# # AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
# #
# # Tags are not supported by this resource
# resource "aws_route53_record" "icehack-node16" {
#     zone_id = "${aws_route53_zone.Icehack.id}"

#     name = "node16"
#     type = "A"
#     ttl = "300"
#     records = [
#         "${aws_eip.icehack-prod-node16.public_ip}"
#     ]
# }

# # Virtual Environment VM - Accessible worldwide
# #
# # This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# # This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# # This resource implicitly depends on the 'aws_security_group.all-egress' resource
# # This resource implicitly depends on the 'aws_security_group.ping' resource
# # This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# # This resource implicitly depends on the 'aws_security_group.http-world' resource
# # This resource implicitly depends on the 'aws_security_group.https-world' resource
# #
# # AWS source: https://aws.amazon.com/ec2/
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
# resource "aws_instance" "icehack-prod-node17" {
#     instance_type = "t2.micro"
#     ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
#     key_name = "${var.aws_ssh_key}"

#     subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
#     vpc_security_group_ids = [
#         "${aws_security_group.all-egress.id}",
#         "${aws_security_group.ping.id}",
#         "${aws_security_group.ssh-world.id}",
#         "${aws_security_group.http-world.id}",
#         "${aws_security_group.https-world.id}"
#     ]

#     tags {
#         Name = "icehack-prod-node17"
#         X-Project = "Icehack"
#         X-Purpose = "Node"
#         X-Subnet = "External"
#         X-Managed-By = "Terraform"
#     }
# }

# # This resource implicitly depends on the 'aws_instance.icehack-prod-node17' resource
# #
# # AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
# #
# # Tags are not supported by this resource
# resource "aws_eip" "icehack-prod-node17" {
#     instance = "${aws_instance.icehack-prod-node17.id}"
#     vpc = true
# }

# # This resource implicitly depends on the 'aws_eip.icehack-prod-node17' resource
# # This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
# #
# # AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
# #
# # Tags are not supported by this resource
# resource "aws_route53_record" "icehack-prod-node17" {
#     zone_id = "${aws_route53_zone.Icehack.id}"

#     name = "icehack-prod-node17"
#     type = "A"
#     ttl = "300"
#     records = [
#         "${aws_eip.icehack-prod-node17.public_ip}"
#     ]
# }

# # This resource implicitly depends on the 'aws_eip.icehack-prod-node17' resource
# # This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
# #
# # AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
# #
# # Tags are not supported by this resource
# resource "aws_route53_record" "icehack-node17" {
#     zone_id = "${aws_route53_zone.Icehack.id}"

#     name = "node17"
#     type = "A"
#     ttl = "300"
#     records = [
#         "${aws_eip.icehack-prod-node17.public_ip}"
#     ]
# }

# # Virtual Environment VM - Accessible worldwide
# #
# # This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# # This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# # This resource implicitly depends on the 'aws_security_group.all-egress' resource
# # This resource implicitly depends on the 'aws_security_group.ping' resource
# # This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# # This resource implicitly depends on the 'aws_security_group.http-world' resource
# # This resource implicitly depends on the 'aws_security_group.https-world' resource
# #
# # AWS source: https://aws.amazon.com/ec2/
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
# resource "aws_instance" "icehack-prod-node18" {
#     instance_type = "t2.micro"
#     ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
#     key_name = "${var.aws_ssh_key}"

#     subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
#     vpc_security_group_ids = [
#         "${aws_security_group.all-egress.id}",
#         "${aws_security_group.ping.id}",
#         "${aws_security_group.ssh-world.id}",
#         "${aws_security_group.http-world.id}",
#         "${aws_security_group.https-world.id}"
#     ]

#     tags {
#         Name = "icehack-prod-node18"
#         X-Project = "Icehack"
#         X-Purpose = "Node"
#         X-Subnet = "External"
#         X-Managed-By = "Terraform"
#     }
# }

# # This resource implicitly depends on the 'aws_instance.icehack-prod-node18' resource
# #
# # AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
# #
# # Tags are not supported by this resource
# resource "aws_eip" "icehack-prod-node18" {
#     instance = "${aws_instance.icehack-prod-node18.id}"
#     vpc = true
# }

# # This resource implicitly depends on the 'aws_eip.icehack-prod-node18' resource
# # This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
# #
# # AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
# #
# # Tags are not supported by this resource
# resource "aws_route53_record" "icehack-prod-node18" {
#     zone_id = "${aws_route53_zone.Icehack.id}"

#     name = "icehack-prod-node18"
#     type = "A"
#     ttl = "300"
#     records = [
#         "${aws_eip.icehack-prod-node18.public_ip}"
#     ]
# }

# # This resource implicitly depends on the 'aws_eip.icehack-prod-node18' resource
# # This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
# #
# # AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
# #
# # Tags are not supported by this resource
# resource "aws_route53_record" "icehack-node18" {
#     zone_id = "${aws_route53_zone.Icehack.id}"

#     name = "node18"
#     type = "A"
#     ttl = "300"
#     records = [
#         "${aws_eip.icehack-prod-node18.public_ip}"
#     ]
# }

# # Virtual Environment VM - Accessible worldwide
# #
# # This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# # This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# # This resource implicitly depends on the 'aws_security_group.all-egress' resource
# # This resource implicitly depends on the 'aws_security_group.ping' resource
# # This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# # This resource implicitly depends on the 'aws_security_group.http-world' resource
# # This resource implicitly depends on the 'aws_security_group.https-world' resource
# #
# # AWS source: https://aws.amazon.com/ec2/
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
# resource "aws_instance" "icehack-prod-node19" {
#     instance_type = "t2.micro"
#     ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
#     key_name = "${var.aws_ssh_key}"

#     subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
#     vpc_security_group_ids = [
#         "${aws_security_group.all-egress.id}",
#         "${aws_security_group.ping.id}",
#         "${aws_security_group.ssh-world.id}",
#         "${aws_security_group.http-world.id}",
#         "${aws_security_group.https-world.id}"
#     ]

#     tags {
#         Name = "icehack-prod-node19"
#         X-Project = "Icehack"
#         X-Purpose = "Node"
#         X-Subnet = "External"
#         X-Managed-By = "Terraform"
#     }
# }

# # This resource implicitly depends on the 'aws_instance.icehack-prod-node19' resource
# #
# # AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
# #
# # Tags are not supported by this resource
# resource "aws_eip" "icehack-prod-node19" {
#     instance = "${aws_instance.icehack-prod-node19.id}"
#     vpc = true
# }

# # This resource implicitly depends on the 'aws_eip.icehack-prod-node19' resource
# # This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
# #
# # AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
# #
# # Tags are not supported by this resource
# resource "aws_route53_record" "icehack-prod-node19" {
#     zone_id = "${aws_route53_zone.Icehack.id}"

#     name = "icehack-prod-node19"
#     type = "A"
#     ttl = "300"
#     records = [
#         "${aws_eip.icehack-prod-node19.public_ip}"
#     ]
# }

# # This resource implicitly depends on the 'aws_eip.icehack-prod-node19' resource
# # This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
# #
# # AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# # Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
# #
# # Tags are not supported by this resource
# resource "aws_route53_record" "icehack-node19" {
#     zone_id = "${aws_route53_zone.Icehack.id}"

#     name = "node19"
#     type = "A"
#     ttl = "300"
#     records = [
#         "${aws_eip.icehack-prod-node19.public_ip}"
#     ]
# }

#
# These nodes are secondary production nodes - for use by Icehack helpers to develop examples and other general testing
#

# Virtual Environment VM - Accessible worldwide
#
# This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# This resource implicitly depends on the 'aws_security_group.all-egress' resource
# This resource implicitly depends on the 'aws_security_group.ping' resource
# This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# This resource implicitly depends on the 'aws_security_group.http-world' resource
# This resource implicitly depends on the 'aws_security_group.https-world' resource
#
# AWS source: https://aws.amazon.com/ec2/
# Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "icehack-prod-node20" {
    instance_type = "t2.micro"
    ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
    key_name = "${var.aws_ssh_key}"

    subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
    vpc_security_group_ids = [
        "${aws_security_group.all-egress.id}",
        "${aws_security_group.ping.id}",
        "${aws_security_group.ssh-world.id}",
        "${aws_security_group.http-world.id}",
        "${aws_security_group.https-world.id}"
    ]

    tags {
        Name = "icehack-prod-node20"
        X-Project = "Icehack"
        X-Purpose = "Node"
        X-Subnet = "External"
        X-Managed-By = "Terraform"
    }
}

# This resource implicitly depends on the 'aws_instance.icehack-prod-node20' resource
#
# AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
#
# Tags are not supported by this resource
resource "aws_eip" "icehack-prod-node20" {
    instance = "${aws_instance.icehack-prod-node20.id}"
    vpc = true
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node20' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-prod-node20" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "icehack-prod-node20"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node20.public_ip}"
    ]
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node20' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-node20" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "node20"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node20.public_ip}"
    ]
}

# Virtual Environment VM - Accessible worldwide
#
# This resource implicitly depends on the 'atlas_artifact.antarctica-icehack-latest' resource
# This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# This resource implicitly depends on the 'aws_security_group.all-egress' resource
# This resource implicitly depends on the 'aws_security_group.ping' resource
# This resource implicitly depends on the 'aws_security_group.ssh-world' resource
# This resource implicitly depends on the 'aws_security_group.http-world' resource
# This resource implicitly depends on the 'aws_security_group.https-world' resource
#
# AWS source: https://aws.amazon.com/ec2/
# Terraform source: https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "icehack-prod-node21" {
    instance_type = "t2.micro"
    ami = "${atlas_artifact.antarctica-icehack-latest.metadata_full.region-eu-west-1}"
    key_name = "${var.aws_ssh_key}"

    subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
    vpc_security_group_ids = [
        "${aws_security_group.all-egress.id}",
        "${aws_security_group.ping.id}",
        "${aws_security_group.ssh-world.id}",
        "${aws_security_group.http-world.id}",
        "${aws_security_group.https-world.id}"
    ]

    tags {
        Name = "icehack-prod-node21"
        X-Project = "Icehack"
        X-Purpose = "Node"
        X-Subnet = "External"
        X-Managed-By = "Terraform"
    }
}

# This resource implicitly depends on the 'aws_instance.icehack-prod-node21' resource
#
# AWS source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#VPC_EIPConcepts
# Terraform source: https://www.terraform.io/docs/providers/aws/r/eip.html
#
# Tags are not supported by this resource
resource "aws_eip" "icehack-prod-node21" {
    instance = "${aws_instance.icehack-prod-node21.id}"
    vpc = true
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node21' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-prod-node21" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "icehack-prod-node21"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node21.public_ip}"
    ]
}

# This resource implicitly depends on the 'aws_eip.icehack-prod-node21' resource
# This resource implicitly depends on the 'aws_route53_zone.Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route53_record.html
#
# Tags are not supported by this resource
resource "aws_route53_record" "icehack-node21" {
    zone_id = "${aws_route53_zone.Icehack.id}"

    name = "node21"
    type = "A"
    ttl = "300"
    records = [
        "${aws_eip.icehack-prod-node21.public_ip}"
    ]
}
