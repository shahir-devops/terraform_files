resource "aws_instance" "amiid" {
  ami           = var.amiid
  instance_type = var.type
  key_name      = var.keyname
  depends_on    = [aws_s3_bucket.s3_object]
}
resource "aws_s3_bucket" "s3_object" {
  bucket = var.bucketname
}

/*
First it will create bucket and move to create ec2 instance
ec2 is depend on bucket
*/