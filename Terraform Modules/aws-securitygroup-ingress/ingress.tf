#########################################
#Creates Inbound rules for Security Group
#########################################
resource "aws_security_group_rule" "allow_all" {
    type = "ingress"
    from_port = "${var.ingress_from_port}"
    to_port = "${var.ingress_to_port}"
    protocol = "${var.ingress_protocol}"
    cidr_blocks = ["${var.ingress_cidr_blocks}"]
    security_group_id = "${var.security_group_id}"
}

