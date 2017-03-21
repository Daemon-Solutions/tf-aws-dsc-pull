resource "aws_s3_bucket" "dsc" {
  bucket = "${var.customer}-${var.envname}-dsc"
  acl    = "private"

  tags {
    Name = "${var.customer}-${var.envname}-dsc_pull_server"
  }
}

resource "aws_s3_bucket_object" "ps-scripts" {
  depends_on = ["aws_s3_bucket.dsc"]

  count  = "${length(var.dsc_configs)}"
  bucket = "${var.customer}-${var.envname}-dsc"
  key    = "${element(var.dsc_configs, count.index)}"
  source = "${path.module}/dsc/${element(var.dsc_configs, count.index)}"
}
