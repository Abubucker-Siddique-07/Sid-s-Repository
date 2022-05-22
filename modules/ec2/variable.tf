variable "key_name" { 
}

variable "instance_name" {
  default = "EC2-TEST-III"
}


variable "instance_type" {
  default = "t2.micro"
}


variable "owners" {
    type = list(string)
  default = ["self"]
}

variable "iam_instance_profile" {
}

variable "private_key_pem" {
}

variable "root_path" {
  default = "/home/ec2-user"
}

variable "bucket_name" {
}

variable "filter_tags" {
  type = object({
    name_tag = string
    name_values = list(string)
    id_tag = string
    id_values = list(string)
  })

  default = {
    id_tag = "tag:Id"
    id_values = [ "1" ]
    name_tag = "tag:Name"
    name_values = [ "my_custom_ami" ]
  }
}

variable "connection_type" {
  default = "ssh"
}

variable "connection_user" {
   default = "ec2-user"
}
