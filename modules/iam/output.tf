output "instance_profile" {
  value = aws_iam_instance_profile.my_ec2_profile.name
}

output "lambda_test_role" {
  value = aws_iam_role.lambda_test_role.arn
  
}