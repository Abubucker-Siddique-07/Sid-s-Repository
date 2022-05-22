#EC2 IAM ROLE FOR EC2

resource "aws_iam_role" "EC2_instance_test_role" {
    name = var.instance_role
    assume_role_policy = file("${path.module}/config/ec2_iam_role.json")
}

#EC2 IAM POLICY FOR EC2
resource "aws_iam_policy" "EC2_instance_test_policy" {
    name = var.instance_policy
    policy = file("${path.module}/config/ec2_iam_policy.json")
}

#EC2 IAM POLICY AND ROLE ATTACHMENTFOR EC2
resource "aws_iam_role_policy_attachment" "EC2_instance_test_role_policy"{
    role = aws_iam_role.EC2_instance_test_role.name
    policy_arn = aws_iam_policy.EC2_instance_test_policy.arn
}

#EC2 INSTANCE PROFILE
resource "aws_iam_instance_profile" "my_ec2_profile" {
  name = var.instance_profile_name
  role = aws_iam_role.EC2_instance_test_role.name
}

#IAM ROLE FOR LAMDA

resource "aws_iam_role" "lambda_test_role" {
    name = var.lambda_test_role_name
    assume_role_policy = file("${path.module}/config/lambda_iam_role.json")
}

resource "aws_iam_policy" "lambda_test_policy" {
    name = var.lambda_test_policy_name
    policy = file("${path.module}/config/lambda_iam_policy.json")
}

resource "aws_iam_role_policy_attachment" "lambda_test_role_policy" {
    role = aws_iam_role.lambda_test_role.name
    policy_arn = aws_iam_policy.lambda_test_policy.arn
  
}


