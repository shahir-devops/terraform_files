resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "lambda-bucket-shahir"
  acl = "private"
  force_destroy = true

  tags = {
    Name = "lambdaBucket"
  }
}

resource "aws_s3_object" "lambda_code"{
    bucket = aws_s3_bucket.lambda_bucket.id
    key = "lambda.zip"
    source = "lambda.zip"
    etag = filemd5("lambda.zip")
}

resource "aws_lambda_function" "my_lambda" {
  function_name = "my-lambda"
  role          = "arn:aws:iam::956172363228:role/aws_lambda"
  handler       = "lambda.lambda_handler" #replace with your function name
  runtime       = "python3.9"
  s3_bucket = aws_s3_bucket.lambda_bucket.id # bucket name 
  s3_key = aws_s3_object.lambda_code.key # inside the bucket 
  timeout = 10
  memory_size = 128

  environment {
    variables = {
        PRODUCTION = "production" 
    }
  }
  tags = {
    Name = "myLambda function"
  }
 }

