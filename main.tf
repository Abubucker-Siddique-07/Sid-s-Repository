module "iam" {
    source = "./modules/iam"
}

module "key-pair" {
    source = "./modules/key-pair"
}

module "s3"{
    source = "./modules/s3"
}

module "lambda" {
    source = "./modules/lambda"
    lambda_test_role = module.iam.lambda_test_role
    bucket_name = module.s3.bucket_name
}

module "ec2" {
    source = "./modules/ec2"
    key_name = module.key-pair.key_name
    iam_instance_profile = module.iam.instance_profile
    private_key_pem = module.key-pair.private_key_pem
    bucket_name = module.s3.bucket_name
}

