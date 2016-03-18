#
# BAS Icehack AWS Virtual Private Cloud (VPC) Terraform resource configuration
# This file is used to define the Virtual Private Cloud (VPC) used to contain all networked resources used by BAS in
# AWS for the Icehack event, such as EC2 instances.
#
# A VPC includes multiple sub-resources such as subnets and security groups. These are configured in related files:
# * 12-vpc-subnets.tf  -- Defines VPC Subnets and Routes
# * 14-vpc-security.tf -- Defines VPC Security Groups and Network ACLs
#
# Source: https://aws.amazon.com/vpc/
#
# Currently only a single VPC is used for all networked resources used by in BAS for the Icehack event.
#
# This file relies on the AWS Terraform provider being previously configured.

# Default VPC
# AWS includes a default VPC, with subnets and other features, in all AWS accounts.
# Whilst it possible to remove this VPC it is against best practice to do so. However users **MUST NOT** use this VPC
# without first discussing this with the BAS Web & Applications Team.
#
# Source: http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/default-vpc.html

# BAS Icehack VPC
# The BAS Icehack VPC uses a configuration described by AWS as 'VPC with a Single Public Subnet' or 'Scenario 1'.
# It consists of a network with a '/16' CIDR block, within which sits a single '/24' subnet.
#
# Source: http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Scenario1.html
#
# The composition of this VPC and its related resources such as Security Groups and Network ACLs are configured
# according to the AWS documentation. Some changes have been made to adapt to our requirements and use-cases:
#
# * We don't enable Windows remote desktop ports as we don't use windows hosts
# * We don't enable any database ports as we don't use database services

# The overall BAS Icehack VPC
# An internet gateway resource connects this VPC to the Internet and other parts of AWS
# See previous comments for more details on how this resource is configured.
#
# AWS source: https://aws.amazon.com/vpc/
# Terraform source: https://www.terraform.io/docs/providers/aws/r/vpc.html
resource "aws_vpc" "BAS-VPC-Icehack" {

    # This is the default CIDR block suggested by AWS and offers a pool of 65,536 available addresses.
    #
    # In previous versions of the BAS VPC, an CIDR block was chosen as not to clash with the provision of private
    # addresses used within BAS and NERC. The intention was to allow easy identification, from the CIDR block used, as
    # whether an IP address is for a host on AWS or elsewhere. As the available block for AWS hosts was within an
    # existing private IP address space, this is much harder to eyeball (especially when performed infrequently).
    # Additionally, were a 'hybrid cloud' approach to be deployed between BAS systems and AWS other networking
    # constraints would force the use of NAT and other techniques making the choice of CIDR block used in AWS less
    # critical for avoiding clashes. For this reason no provision is made in version 2 or later of the BAS VPC to
    # prevent clashes between the BAS VPC and the wider BAS/NERC network.
    #
    # Note: Support for IPv6 is currently limited within AWS, and is not available for use within a VPC.
    cidr_block = "10.0.0.0/16"

    enable_dns_support = true
    enable_dns_hostnames = true

    tags {
        Name = "BAS VPC Icehack"
        X-Managed-By = "Terraform"
    }
}

# An Internet Gateway connects a VPC directly to the internet
# Additional VPC elements such as Routing Tables, Security Groups and Network ACLs will all need to also allow access
#
# This resource implicitly depends on the 'aws_vpc.BAS-VPC-Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Internet_Gateway.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/internet_gateway.html
resource "aws_internet_gateway" "BAS-VPC-Icehack" {
    vpc_id = "${aws_vpc.BAS-VPC-Icehack.id}"

    tags {
        Name = "BAS VPC Icehack - Internet Gateway"
        X-Managed-By = "Terraform"
    }
}
