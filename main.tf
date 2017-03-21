resource "aws_instance" "dsc" {
  ami                    = "${data.aws_ami.windows.id}"
  subnet_id              = "${element(var.private_subnets, 0)}"
  instance_type          = "${var.instance_type}"
  user_data              = "<powershell>${data.template_file.apply_cert_userdata.rendered}${data.template_file.dsc_userdata.rendered}</powershell><persist>true</persist>"
  iam_instance_profile   = "${module.iam_instance_profile_dsc_pull.profile_id}"
  vpc_security_group_ids = ["${aws_security_group.dsc_pull.id}", "${var.ads_sg}"]
  key_name               = "${var.key_name}"

  tags {
    Name = "${var.customer}-${var.envname}-dsc_pull_server"
  }
}
