resource "aws_lambda_function" "my_lambda" {
  function_name = "my-lambda"
  role          = "arn:aws:iam::956172363228:role/aws_lambda"
  handler       = "lambda.lambda_handler" #lambda is file name and lambda_handler is a function name 
  runtime       = "python3.9"

  filename         = "lambda.zip"
  source_code_hash = filebase64sha256("lambda.zip")
}

