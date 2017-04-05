######################################################################
## Create EC2 instance
###

resource "template_file" "user_data" {
    template  = "${file(var.userdata)}"
    vars {
        computer_name = "${var.name}"
		ou = "${var.ou}"
		domain_user = "${var.domain_user}"
		domain_pwd = "${var.domain_pwd}"
		domain_name = "${var.domain_name}"
		serviceou = "${var.serviceou}"
		prod_svc_user = "${var.prod_svc_user}"
		prod_svc_pwd = "${var.prod_svc_pwd}"
		lite_key = "${var.lite_key}"
		lite_msg = "${var.lite_msg}"
		
    }
}

resource "aws_instance" "db-instance" {
    ami = "${var.ami}"
    instance_type = "${var.instancestype}"
	key_name = "${var.aws_key_name}"
	subnet_id = "${var.subnet_id}"
	availability_zone = "${var.availability_zone}"
	vpc_security_group_ids = ["${var.sg_id}"]
	user_data="${template_file.user_data.rendered}"
	iam_instance_profile = "${var.instance_profile_name}"
	root_block_device {
                                volume_type = "gp2"
                                volume_size = "${var.c_drive_size}"
                                delete_on_termination = "true"
                }                              
                ebs_block_device {
                                device_name    = "/dev/xvdb"
                                volume_type = "standard"
                                volume_size = "${var.d_drive_size}"
                                delete_on_termination = "true"               
                }
                ebs_block_device {
                                device_name    = "/dev/xvdc"
                                volume_type = "standard"
                                volume_size = "${var.e_drive_size}"
                                delete_on_termination = "true"               
                }
                ebs_block_device {
                                device_name    = "/dev/xvdd"
                                volume_type = "standard"
                                volume_size = "${var.f_drive_size}"
                                delete_on_termination = "true"               
                }
                ebs_block_device {
                                device_name    = "/dev/xvde"
                                volume_type = "standard"
                                volume_size = "${var.g_drive_size}"
                                delete_on_termination = "true"               
                }				
    tags {
        "Name" 				= "${var.name}"
		"Application ID" 	= "${var.application_id_tag}"
		"Environment" 		= "${var.environment_tag}"		
		"Owner"				= "${var.owner_tag}"
		"Business Unit"		= "${var.business_unit_tag}"
		"Security" 			= "${var.security_tag}"
		"Application Role"	= "${var.application_role_tag}"
		"Automation"		= "${var.automation_tag}"
		"Financial"			= "${var.financial_tag}"
    }
}