resource "tls_private_key" "terraform_private_key" {
  algorithm = var.tls_private_key_algorithm
  rsa_bits  = var.tls_private_key_rsa_bits
}

resource "aws_key_pair" "terraform_key" {
    key_name = var.key_name
    public_key = tls_private_key.terraform_private_key.public_key_openssh
    depends_on = [tls_private_key.terraform_private_key]
}

resource "local_file" "terraform_private_key" {
    content = tls_private_key.terraform_private_key.private_key_openssh
    filename = var.local_pem_file
}