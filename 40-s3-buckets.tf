#
# BAS Icehack AWS Simple Storage Service (S3) Terraform resource configuration
# This file is used to define the S3 Buckets used to contain all storage resources used by BAS in AWS for the Icehack
# event, such as data sets and virtual environment images.

# Icehack bucket
# Contains data-sets and base images for use in the Icehack event
#
# AWS source: https://aws.amazon.com/s3/
# Terraform source: https://www.terraform.io/docs/providers/aws/r/s3_bucket.html
resource "aws_s3_bucket" "bas-icehack" {
    bucket = "bas-icehack"

    # Canned ACL - All objects can be read by anyone, but only the owner can change them
    #
    # Source: https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl
    acl = "public-read"

    # Bucket policy - All objects can be read by anyone, but only the owner can change them
    #
    # http://docs.aws.amazon.com/AmazonS3/latest/dev/example-bucket-policies.html#example-bucket-policies-use-case-2
    policy = "${file("41-bas-icehack-bucket-policy.json")}"

    tags {
        Name = "BAS-Icehack"
        X-Project = "Icehack"
        X-Managed-By = "Terraform"
    }
}
