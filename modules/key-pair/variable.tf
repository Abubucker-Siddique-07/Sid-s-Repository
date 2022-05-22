variable "key_name" {
  default = "terraform_test_key"
}

variable "local_pem_file" {
  default = "terraform_private_key.pem"
}

variable "tls_private_key_algorithm" {
  default = "RSA" 
}

variable "tls_private_key_rsa_bits" {
  type = number
  default = 4096 
}