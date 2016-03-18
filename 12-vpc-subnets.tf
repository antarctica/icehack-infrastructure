#
# BAS Icehack AWS Virtual Private Cloud (VPC) Subnets Terraform resource configuration
# This file is used to define subnet related resources, namely Subnets and Routes, used within the Virtual Private
# Cloud (VPC) used by BAS in AWS for the Icehack event.
#
# This file defines a subset of the resources contained in a VPC. These other resources, and the VPC itself, are
# configured in related files:
# * 10-vpc.tf -- Defines the overall VPC with an outline of how the VPC, and its individual components, are designed

# BAS Icehack VPC Subnets
# As described in the outline of the BAS Icehack VPC, one Subnet is used, which is publicly accessible.

# External (Public) subnet for the BAS Icehack VPC
# Hosts in this subnet are intended to be accessible from the internet (e.g. Virtual Environments)
# IP addresses assigned in this subnet are not themselves public, Elastic IPs must be used for this
#
# This resource implicitly depends on the 'aws_vpc.BAS-VPC-Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Subnets.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/subnet.html
resource "aws_subnet" "BAS-VPC-Icehack-External" {
    vpc_id = "${aws_vpc.BAS-VPC-Icehack.id}"

    # This is the default CIDR block suggested by AWS and offers a pool of 256 private addresses
    cidr_block = "10.0.0.0/24"

    availability_zone = "eu-west-1a"

    # When true, instances launched into this subnet will be automatically assigned a NATed public IP address
    # For persistent public addresses that can be manually released use an Elastic IP resource
    #
    # Source: http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-ip-addressing.html#subnet-public-ip
    map_public_ip_on_launch = true

    tags {
        Name = "External Subnet"
        X-VPC-Subnet = "External"
        X-Managed-By = "Terraform"
    }
}

# Main route table associated with the External subnet
# This table enables hosts in this subnet to communicate with other instances in the VPC, and communicate directly
# with the Internet
#
# This resource implicitly depends on the 'aws_vpc.BAS-VPC-Icehack' resource
# This resource implicitly depends on the 'aws_internet_gateway.BAS-VPC-Icehack' resource
#
# AWS source: http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Route_Tables.html
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route_table.html
resource "aws_route_table" "BAS-VPC-Icehack-External" {
    vpc_id = "${aws_vpc.BAS-VPC-Icehack.id}"

    route {
        cidr_block = "0.0.0.0/0"

        # By connecting to an Internet Gateway hosts in this subnet can communicate directly with the Internet
        gateway_id = "${aws_internet_gateway.BAS-VPC-Icehack.id}"
    }

    tags {
        Name = "External Subnet"
        X-VPC-Subnet = "External"
        X-Managed-By = "Terraform"
    }
}

# Associates the relevant Routing Table with the relevant Subnet
#
# This resource implicitly depends on the 'aws_subnet.BAS-VPC-Icehack-External' resource
# This resource implicitly depends on the 'aws_route_table.BAS-VPC-Icehack-External' resource
#
# Terraform source: https://www.terraform.io/docs/providers/aws/r/route_table_association.html
#
# Tags are not supported by this resource
resource "aws_route_table_association" "BAS-VPC-Icehack-External" {
    subnet_id = "${aws_subnet.BAS-VPC-Icehack-External.id}"
    route_table_id = "${aws_route_table.BAS-VPC-Icehack-External.id}"
}
