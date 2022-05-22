variable "instance_role" {
  default = "EC2_insstance_test_role"
}

variable "instance_policy" {
  default = "EC2_instance_test_policy"
}

variable "instance_profile_name" {
  default = "EC2_TEST_PROFILE"
}

variable "lambda_test_role_name" {
  default = "my_terra_lambda_role"  
}

variable "lambda_test_policy_name" {
  default = "my_terra_lambda_policy" 
}