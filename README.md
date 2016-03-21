# BAS Icehack AWS

This project summarises the setup and usage of Amazon Web Services (AWS) for the Icehack event.

Note: This documentation is designed to provide information and guidance on how AWS is used for the Icehack event. 
It is not designed to be used instead of official AWS documentation, or as a guide on how to use AWS. 

### Portals

The [AWS console](https://british-antarctic-survey.signin.aws.amazon.com/console) is used for managing all AWS 
services, including user access (except individuals) and excluding billing.

### Default region

All instances of services (such as EC instances and S3 buckets) are located in the *EU - Ireland* AWS Region.

## Implementation

AWS features used for Icehack are implemented using the AWS APIs via [Terraform](https://terraform.io).
See the linked files below for each service or topic:

Some additional elements are discussed directly in this section as needed.

* [Terraform providers](00-providers.tf)

* [Virtual Private Cloud (VPC)](10-vpc.tf)

* [Route53 (DNS)](20-route53.tf)

* [EC2](30-ec2.md)

* [Simple Storage Service (S3)](40-s3.md)

### Terraform state

State information for this project is stored within this project.

## Developing

### Requirements

* SSH
* Git
* Terraform (minimum version: 0.6.9)

* Suitable access and permissions to clone (and optionally push) from(/to) the project repository [1]
* Suitable permissions in the BAS AWS account, with relevant environment variables set [2]
* A public key suitably registered in the BAS AWS account for launching EC2 instances

Note: Contact the Web & Applications Team for any missing permissions.

[1] https://stash.ceh.ac.uk/projects/ICEHACK16/repos/icehack-infrastructure/browse

[2] Typically an IAM user with the administrator role is used
 
### Setup

Clone repository:

```
$ git clone https://github.com/antarctica/icehack-infrastructure.git
```

## Licence

Copyright 2016 NERC BAS.

Unless stated otherwise, all documentation is licensed under the Open Government License - version 3.
All code is licensed under the MIT license.

Copies of these licenses are included within this project.
