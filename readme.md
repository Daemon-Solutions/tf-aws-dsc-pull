tf-aws-dsc-pull
========================

This module is for creating a Windows DSC Pull Server

Prerequisites
-------------

There are some specific requirements when using this module, these are listed below;

- Windows operating system must have WMF 5.1 or greater installed

- The certificate must be in pfx format, stored in a "certs" directory in the terraform directory.  It is best practice to keep the certs folder local to avoid storing in GIT repository.

- Use an s3 resource to upload the the certificate, you can then reference the bucket and object id's when calling the module.

- Manually create an SSM parameter of a secure string, this secure string should contain the password for the pfx file, you can then pass the name of this SSM parameter into the rdgw module.

- Release >v0.3.1 of module tf-aws-iam-instance-profile


Usage
-----

Declare a module in your Terraform file, for example:

## module for Windows DSC Pull Server

```js
module "dsc_pull" {
  source = "../localmodules/tf-aws-ms-dsc"

  private_subnets = ["${element(data.terraform_remote_state.vpc.private_subnets, 0)}"]
  instance_type   = "t2.medium"
  key_name        = "${var.key_name}"
  ads_dns         = "${data.terraform_remote_state.vpc.ads_dns}"
  ad_type         = "${data.terraform_remote_state.vpc.ad_type}"
  domain_password = "${data.terraform_remote_state.vpc.domain_password}"
  local_password  = "${var.local_password}"
  ads_sg          = "${data.terraform_remote_state.vpc.ads_sg_id}"
  customer        = "${var.customer}"
  envtype         = "${var.envtype}"
  envname         = "${var.envname}"
  domain_name     = "${var.domain_name}"

  cert_bucket        = "${data.terraform_remote_state.vpc.cert_bucket}"
  cert_file          = "${data.terraform_remote_state.vpc.cert_file}"
  cert_pass_ssmparam = "bowser-cert"
}

```

Variables
---------

- `customer` - name of customer
- `envtype`  - name of environment type
- `envname`  - name of environment

- `private_subnets`     - list of private subnets
- `instance_type`       - ec2 instance type
- `key_name`            - keypair name
- `ads_dns`             - [list of ads dns servers]
- `ad_type`             - type of ads MicrosoftAD or SimpleAD
- `domain_password      - active directory domain password
- `local_password`      - local password for rdgw instances
- `ads_sg`              - id of ads security group
- `domain_name`         - type of ads MicrosoftAD or SimpleAD
- `cert_bucket`         - bucket id where cert is stored
- `cert_file`           - filename of cert object in s3 bucket
- `ssm_pass_ssmparam    - name of ssm parameter where encrypted cert password is stored


