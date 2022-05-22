#CREATE ARCHIVE LAMBDA_FUNCTION
data "archive_file" "lambda_test_function_archive"{
    type = var.archive_file_type
    source_file = "${path.module}/python/lambda_function.py"
    output_path = "${path.module}/lambda_test_function.zip"
}

data "archive_file" "lambda_test_function2_archive"{
    type = var.archive_file_type
    source_file = "${path.module}/python/lambda_function2.py"
    output_path = "${path.module}/lambda_test_function2.zip"
}

#LAMBDA FUNCTION
resource "aws_lambda_function" "lambda_test_function" {
    filename      = "${path.module}/lambda_test_function.zip"
    function_name = var.lambda_test_function_name
    role          = var.lambda_test_role
    handler       = var.lambda_test_function_handler
    runtime       = var.lambda_test_function_runtime 
}

#LAMBDA FUNCTION 2
resource "aws_lambda_function" "lambda_test_function2" {
    filename      = "${path.module}/lambda_test_function2.zip"
    function_name = var.lambda_test_function_name2
    role          = var.lambda_test_role
    handler       = var.lambda_test_function_handler2
    runtime       = var.lambda_test_function_runtime 
}

data "aws_s3_bucket" "my_test_bucket"{
    bucket = var.bucket_name
}

#GIVE S3 PERMISSIONS TO ACCESS LAMBDA FUNCTION (invoke)
resource "aws_lambda_permission" "lambda_test_function_permission" {
  action        = var.aws_lambda_permission_action
  function_name = aws_lambda_function.lambda_test_function.function_name
  principal     = var.aws_lambda_permission_principal
  source_arn    = data.aws_s3_bucket.my_test_bucket.arn
}

#GIVE S3 PERMISSIONS TO ACCESS LAMBDA FUNCTION 2 (invoke)
resource "aws_lambda_permission" "lambda_test_function_permission2" {
  action        = var.aws_lambda_permission_action
  function_name = aws_lambda_function.lambda_test_function2.function_name
  principal     = var.aws_lambda_permission_principal
  source_arn    = data.aws_s3_bucket.my_test_bucket.arn
}

#SET S3 BUCKET EVENT FOR TRIGGERING LAMBDA FUNCTIONS
resource "aws_s3_bucket_notification" "lambda_test_funtion_trigger" {
    bucket = data.aws_s3_bucket.my_test_bucket.id
    lambda_function {
        lambda_function_arn = aws_lambda_function.lambda_test_function.arn
        events              = [var.aws_s3_bucket_notification_event]
        filter_prefix       = var.aws_s3_bucket_notification_prefix
        filter_suffix       = var.aws_s3_bucket_notification_suffix
    }

     lambda_function {
        lambda_function_arn = aws_lambda_function.lambda_test_function2.arn
        events              = [var.aws_s3_bucket_notification_event]
        filter_prefix       = var.aws_s3_bucket_notification_prefix2
        filter_suffix       = var.aws_s3_bucket_notification_suffix2
    }
    depends_on = [aws_lambda_permission.lambda_test_function_permission,
                aws_lambda_permission.lambda_test_function_permission2]
}
