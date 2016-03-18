#
# BAS Icehack AWS Elastic Compute Cloud (EC2) Terraform resource configuration
# This file is used to define EC2 resources shared by all instances

# Define using environment variable - e.g. TF_VAR_aws_ssh_key=XXX
# If you require a key pair to be registered please contact the BAS Web & Applications Team.
#
# AWS Source: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html
variable "aws_ssh_key" {}

# Represents the latest version of the antarctica/icehack AWS AIM
#
# Atlas source: https://atlas.hashicorp.com/antarctica/artifacts/icehack/types/amazon.ami
# Terraform source: https://www.terraform.io/docs/providers/atlas/r/artifact.html
resource "atlas_artifact" "antarctica-icehack-latest" {
  name = "antarctica/icehack"
  type = "amazon.ami"
  version = "latest"
}

# Represents the latest version of the antarctica/trusty AWS AIM
#
# Atlas source: https://atlas.hashicorp.com/antarctica/artifacts/trusty/types/amazon.ami
# Terraform source: https://www.terraform.io/docs/providers/atlas/r/artifact.html
resource "atlas_artifact" "antarctica-trusty-latest" {
  name = "antarctica/trusty"
  type = "amazon.ami"
  version = "latest"
}
