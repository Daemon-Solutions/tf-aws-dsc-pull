variable "customer" {}

variable "envname" {}

variable "envtype" {}

variable "service" {
  default = "rdgw"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC."
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC."
  default     = []
}

variable "azs" {
  type    = "list"
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "domain_name" {}

## IAM profile

variable "profile" {
  default = "rdgw"
}

# ADS vars

variable "domain_password" {}

variable "ads_dns" {
  type = "list"
}

variable "ads_sg" {}

#variable "ad_user" {}

## Userdata Variables

variable "rdgw_userdata" {
  default = ""
}

variable "local_password" {}

# ## Launch Configuration Variables & ami lookup

variable "windows_ami_names" {
  default = {
    "2008" = "Windows_Server-2008-R2_SP1-English-64Bit-Base-*"
    "2012" = "Windows_Server-2012-R2_RTM-English-64Bit-Base-*"
    "2016" = "Windows_Server-2016-English-Full-Base*"
  }
}

variable "windows_ver" {
  default = "2016"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "key_name" {}

## Security Groups Variables
#
# - 195.102.251.16/28 -- LinuxIT Bristol
# - 54.76.122.23/32   -- Bashton OpenVPN
# - 88.97.72.136/32   -- Bashton Office
# - 195.8.68.130/32   -- Claranet London Office
#
variable "rdgw_ssh_cidrs" {
  default = ["88.97.72.136/32", "54.76.122.23/32", "195.102.251.16/28", "195.8.68.130/32"]
}

## elb vars

variable "admin_users" {
  default = {
    "SimpleAD"    = "administrator"
    "MicrosoftAD" = "admin"
  }
}

variable "ad_type" {}

variable "dsc_configs" {
  default = [
    "dsc-smtp-server.ps1",
    "dsc-web-server.ps1",
    "setup-dsc.ps1",
    "createmofs.xml",
    "scheduled-task.ps1",
  ]
}

variable "cert_bucket" {}
variable "cert_file" {}
variable "cert_pass_ssmparam" {}
