######################################
#Creates Outbound rules for Security Group
##
resource "aws_security_group_rule" "allow_all" {
    type = "egress"
    from_port = "${var.egress_from_port}"
    to_port = "${var.egress_to_port}"
    protocol = "${var.egress_protocol}"
    cidr_blocks = ["${var.egress_cidr_blocks}"]
    security_group_id = "${var.security_group_id}"
}

