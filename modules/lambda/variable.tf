variable "lambda_test_role" {
  
}
variable "archive_file_type" {
  default = "zip"
}
variable "lambda_test_function_name" {
    default = "lambda_test_function"
}

variable "lambda_test_function_name2" {
    default = "lambda_test_function2"
}

variable "lambda_test_function_handler" {
    default = "lambda_function.lambda_handler"
}

variable "lambda_test_function_handler2" {
    default = "lambda_function2.lambda_handler2"
}

variable "lambda_test_function_runtime" {
    default = "python3.8"
}

variable "bucket_name" {
}

variable "aws_lambda_permission_action" {
  default = "lambda:InvokeFunction"
}

variable "aws_lambda_permission_principal" {
  default = "s3.amazonaws.com"
}

variable "aws_s3_bucket_notification_event" {
  default = "s3:ObjectCreated:*"
}

variable "aws_s3_bucket_notification_prefix" {
  default = "test_text_files/"
}

variable "aws_s3_bucket_notification_prefix2" {
  default = "md5_result/"
}

variable "aws_s3_bucket_notification_suffix" {
  default = ".trigger"
}

variable "aws_s3_bucket_notification_suffix2" {
  default = "md5_file.dat"
}