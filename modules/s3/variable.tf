variable "bucket_name" {
  default = "my-terra-test-landing-1"
}

variable "bucket_tags" {
    type = object({
        name_tag = string
        description_tag = string
    })
    
    default = {
      description_tag = "Bucket Created with Terraform for test"
      name_tag = "My_Terra_Test_Landing"
    }
}

variable "buket_acl" {
    default = "private"
}