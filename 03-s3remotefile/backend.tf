terraform {
  backend "s3" {
    bucket = "shahir143mithundevops"
    key = "terraform.tfstate"
    region = "ap-south-1"
    profile = "terraformprofile"
    use_lockfile = true
  }
}
#"dynamodb_table" is deprecated. Use parameter "use_lockfile" instead.
#When Terraform initializes the S3 backend, it runs BEFORE the provider block.