#retrieve the latest ami for 2008R2/2012R2/2016

data "aws_ami" "windows" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${lookup(var.windows_ami_names,var.windows_ver)}"]
  }
}

data "aws_vpc" "cidr" {
  id = "${data.aws_subnet.vpc.vpc_id}"
}

data "aws_subnet" "vpc" {
  id = "${element(var.private_subnets,0)}"
}

data "aws_region" "current" {
  current = true
}

data "template_file" "dsc_userdata" {
  template = "${file("${path.module}/include/userdata.tmpl")}"

  vars {
    region          = "${data.aws_region.current.name}"
    ad_user         = "${lookup(var.admin_users,var.ad_type)}"
    dns_servers     = "${element(var.ads_dns,0)},${element(var.ads_dns,1)}"
    local_password  = "${var.local_password}"
    domain_password = "${var.domain_password}"
    domain_name     = "${var.domain_name}"
  }
}

data "template_file" "apply_cert_userdata" {
  template = "${file("${path.module}/include/apply_cert_userdata.tmpl")}"

  vars {
    cert_bucket        = "${var.cert_bucket}"
    cert_file          = "${var.cert_file}"
    cert_pass_ssmparam = "${var.cert_pass_ssmparam}"
    dsc_bucket         = "${aws_s3_bucket.dsc.id}"
  }
}
