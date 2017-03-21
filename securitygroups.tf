## Internal Security Group
resource "aws_security_group" "dsc_pull" {
  name        = "${var.customer}-${var.envname}-dsc-pull"
  vpc_id      = "${data.aws_subnet.vpc.vpc_id}"
  description = "dsc security group"

  egress {
    from_port   = "3389"
    to_port     = "3389"
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.cidr.cidr_block}"]
  }

  ingress {
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.cidr.cidr_block}"]
  }
}
