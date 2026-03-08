resource "aws_instance" "amiid"{
    ami = var.amiid
    instance_type = var.type
    key_name = var.key
}
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucketname
}

# terraform plan -target="aws_s3_bucket.bucket"
# terraform apply -target="aws_s3_bucket.bucket"    