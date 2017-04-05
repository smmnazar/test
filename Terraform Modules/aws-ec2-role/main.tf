######################################################################
# Creating IAM Role for EC2
##
resource "aws_iam_role" "ec2-role" {
    name = "${var.ec2_role}"
    assume_role_policy = "${var.assume_role_policy}"
}

######################################################################
# Creating IAM Role Policy for EC2 Role
##
resource "aws_iam_role_policy" "ec2-policy" {
    name = "${var.ec2_policy}"
    role = "${aws_iam_role.ec2-role.id}"
    policy = "${var.iam_role_policy}"
}

######################################################################
# Creating Instance Profile for ec2 role
##

resource "aws_iam_instance_profile" "instancerole" {
    name = "${var.profilename}"
    roles = ["${aws_iam_role.ec2-role.name}"]
}

output "instance_role_name" {
   value = "${aws_iam_instance_profile.instancerole.name}"
}