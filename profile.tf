module "iam_instance_profile_dsc_pull" {
  source = "../tf-aws-iam-instance-profile"

  name                  = "${var.customer}-dsc_pull"
  ec2_describe          = "1"
  ec2_attach            = "1"
  s3_readonly           = "1"
  r53_update            = "1"
  ssm_managed           = "1"
  ssmparameter_allowall = "1"
}
