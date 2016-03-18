#
# BAS Icehack AWS Virtual Private Cloud (VPC) Security Terraform resource configuration
# This file is used to define security related resources, namely Security Groups and Network ACLs, used within the
# Virtual Private Cloud (VPC) used by BAS in AWS for the Icehack event.
#
# This file defines a subset of the resources contained in a VPC. These other resources, and the VPC itself, are
# configured in related files:
# * 10-vpc.tf -- Defines the overall VPC with an outline of how the VPC, and its individual components are designed

# BAS Icehack VPC Security
# The BAS Icehack VPC implements the Security Groups and Network ACLs recommended by AWS for 'Scenario 1' type VPCs.
# Security Groups and Network ACLs achieve the same results but operate at their respective levels.
#
# Hosts in the public network can be contacted by anyone (e.g. HTTPS/Ping), hosts can make outbound connections
# directly for (TCP) ports over 1024, and to lower ports where explicitly enabled (such as HTTP and databases).
#
# Note: In the case of Network ACLs there are other rules to features of the VPC to work correctly.
# These aren't mentioned in this overview but are discussed in detail where the ACLs are defined.
#
# The main difference being Network ACLs explicitly apply or block traffic, and otherwise take no action, whereas
# Security Groups act block all traffic by default, except where explicitly white-listed. Security Groups must be
# explicitly assigned to resources (such as EC2 instances), whereas Network ACLs will apply to all traffic through
# subnets they are associated with. Both these concepts are discussed in more detail in their respective sections.
#
# Note: Both Security Groups and Network ACLs need to agree - i.e. its not enough to allow SSH to an EC2 instance using
# a Network ACL, the relevant Security Group has to be applied as well.

# Security Groups
# Security Groups are assigned to, and apply to, Instances within a VPC acting as virtual firewalls.
# Each Security Group contains a number of rules to allow traffic with combinations of ports, protocols and sources
# Unlike NetWork ACLs a Security Group acts as a white-list for traffic, with all other traffic being blocked.
#
# Source: http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_SecurityGroups.html

# Allows all outbound traffic (e.g. requests for software updates) on any port and protocol
#
# This resource implicitly depends on the 'aws_vpc.BAS-VPC-Icehack' resource
resource "aws_security_group" "all-egress" {
    vpc_id = "${aws_vpc.BAS-VPC-Icehack.id}"

    name = "All Egress"
    description = "Allows all outbound traffic"

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "All Egress"
        X-Managed-By = "Terraform"
    }
}

# Allows inbound ICMP traffic - typically only used for 'Pinging' a machine from the Internet
#
# This resource implicitly depends on the 'aws_vpc.BAS-VPC-Icehack' resource
resource "aws_security_group" "ping" {
    vpc_id = "${aws_vpc.BAS-VPC-Icehack.id}"

    name = "Ping"
    description = "Allows inbound ICMP traffic"

    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "Ping"
        X-Managed-By = "Terraform"
    }
}

# Allows inbound SSH traffic from anywhere
#
# This resource implicitly depends on the 'aws_vpc.BAS-VPC-Icehack' resource
resource "aws_security_group" "ssh-world" {
    vpc_id = "${aws_vpc.BAS-VPC-Icehack.id}"

    name = "SSH World"
    description = "Allows SSH access from anywhere"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/0"]
    }

    tags {
        Name = "SSH World"
        X-Managed-By = "Terraform"
    }
}

# Allows inbound HTTP traffic (e.g. from Load Balancers to Application Servers) from the Internet
#
# This resource implicitly depends on the 'aws_vpc.BAS-VPC-Icehack' resource
resource "aws_security_group" "http-world" {
    vpc_id = "${aws_vpc.BAS-VPC-Icehack.id}"

    name = "HTTP World"
    description = "Allows HTTP access from anywhere"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "HTTP World"
        X-Managed-By = "Terraform"
    }
}

# Allows inbound HTTPS traffic (e.g. from Clients to Load Balancers) from the Internet
#
# This resource implicitly depends on the 'aws_vpc.BAS-VPC-Icehack' resource
resource "aws_security_group" "https-world" {
    vpc_id = "${aws_vpc.BAS-VPC-Icehack.id}"

    name = "HTTPS World"
    description = "Allows HTTPS access from anywhere"

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "HTTPS World"
        X-Managed-By = "Terraform"
    }
}

# Allows inbound traffic to small-scale, development web-servers such as IPython notebook, php -i, jekyll serve, etc.
#
# This resource implicitly depends on the 'aws_vpc.BAS-VPC-Icehack' resource
resource "aws_security_group" "dev-web-world" {
    vpc_id = "${aws_vpc.BAS-VPC-Icehack.id}"

    name = "Development Web-Server World"
    description = "Allows access to development web-servers from anywhere"

    ingress {
        from_port = 9000
        to_port = 9000
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/0"]
    }

    tags {
        Name = "Development Web-Server World"
        X-Managed-By = "Terraform"
    }
}

# Network ACLs
# Network ACLs are assigned to, and apply to, Subnets within a VPC acting as hardware firewalls.
# Each Network ACL contains a number of, ordered, rules to allow or deny traffic with combinations of ports, protocols
# and sources
# Each Network ACL contains a default rule to deny all inbound or outbound traffic not handled by a preceding rule
#
# Source: http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_ACLs.html
#
# In the case of the 'Scenario 1' Amazon lists a number of recommended Network ACLs, which we mostly implement, except:
# * Rules for technologies we don't use (Windows / Databases) are not included
# * Rules for allowing Ping requests & responses are added - hosts on the External subnet can be 'Pinged' from the
#   Internet
#
# Source: http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Appendix_NACLs.html#VPC_Appendix_NACLs_Scenario_1

# Network ACL for the External Subnet
#
# This resource implicitly depends on the 'aws_vpc.BAS-VPC-Icehack' resource
# This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
resource "aws_network_acl" "BAS-VPC-Icehack-External" {
    vpc_id = "${aws_vpc.BAS-VPC-Icehack.id}"
    subnet_ids = ["${aws_subnet.BAS-VPC-Icehack-External.id}"]

    # Allows inbound HTTP traffic from anywhere
    ingress {
        rule_no = 100
        action = "allow"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_block =  "0.0.0.0/0"
    }

    # Allows inbound HTTPS traffic from anywhere
    ingress {
        rule_no = 110
        action = "allow"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_block =  "0.0.0.0/0"
    }

    # Allows inbound SSH traffic from the anywhere
    ingress {
        rule_no = 120
        action = "allow"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_block = "0.0.0.0/0"
    }

    # Allows inbound Ping requests from anywhere
    ingress {
        rule_no = 130
        action = "allow"
        from_port = -1
        to_port = -1
        icmp_type = 8
        icmp_code = 0
        protocol = "icmp"
        cidr_block = "0.0.0.0/0"
    }

    # Allows inbound return traffic from requests originating in the subnet - using ephemeral ports for NAT
    ingress {
        rule_no = 140
        action = "allow"
        from_port = 1024
        to_port = 65535
        protocol = "tcp"
        cidr_block =  "0.0.0.0/0"
    }

    # Allows outbound HTTP traffic from the subnet to the Internet
    egress {
        rule_no = 100
        action = "allow"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_block =  "0.0.0.0/0"
    }

    # Allows outbound HTTPS traffic from the subnet to the Internet
    egress {
        rule_no = 110
        action = "allow"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_block =  "0.0.0.0/0"
    }

    # Allow outbound Ping replies to the Internet
    egress {
        rule_no = 120
        action = "allow"
        from_port = -1
        to_port = -1
        icmp_type = 0
        icmp_code = 0
        protocol = "icmp"
        cidr_block = "0.0.0.0/0"
    }

    # Allows outbound responses to clients on the Internet using ephemeral ports
    egress {
        rule_no = 130
        action = "allow"
        from_port = 1024
        to_port = 65535
        protocol = "tcp"
        cidr_block =  "0.0.0.0/0"
    }
}
