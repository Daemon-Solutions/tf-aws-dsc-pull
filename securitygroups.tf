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

  egress {
   from_port = "443"
   to_port = "443"
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group_rule" "dsc_pull" {
  type = "ingress"
  from_port = "3389"
  to_port = "3389"
  protocol = "tcp"
  security_group_id = "${aws_security_group.dsc_pull.id}"
  source_security_group_id  = "${var.rdgw_internal_sg}"
}
