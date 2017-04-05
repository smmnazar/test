#Instance
variable "instancestype" {}
variable "ami" {}
variable "aws_key_name" {}
variable "availability_zone" {}
variable "userdata" {}

#ActiveDirectory
variable "ou" {}
variable "serviceou" {}
variable "domain_user" {}
variable "domain_pwd" {}
variable "domain_name" {}
variable "prod_svc_user" {}
variable "prod_svc_pwd" {}

#PowerShell BootStrap
variable "lite_key" {}
variable "lite_msg" {}

#Network and security
variable "subnet_id" {}
variable "sg_id" {}

#Role
variable "instance_profile_name" {}

#Volume size
variable "c_drive_size" {}
variable "d_drive_size" {}
variable "e_drive_size" {}
variable "f_drive_size" {}
variable "g_drive_size" {}

#Tag
variable "name" {}
variable owner_tag {}
variable business_unit_tag {}
variable environment_tag {}
variable application_role_tag {}
variable security_tag {}
variable automation_tag {}
variable financial_tag {}
variable application_id_tag {}