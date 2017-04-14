######################################################################
## Create Security Group 
###

resource "aws_security_group" "sgs" {
  name = "${var.sgname}"
  description = "Security Group for DB instances"
  vpc_id = "${var.vpc_id}"

  tags {
		"Name"				= "${var.name_tag}"
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

######################################################################
## Output
###

output "sg_id" {
   value = "${aws_security_group.sgs.id}"
}