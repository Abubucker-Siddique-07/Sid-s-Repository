output "tls_private_key" {
  value = tls_private_key.terraform_private_key.private_key_openssh
}

output "key_name" {
    value = aws_key_pair.terraform_key.key_name
}

output "private_key_pem"{
    value = tls_private_key.terraform_private_key.private_key_pem
}