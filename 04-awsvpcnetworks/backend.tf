terraform {
  backend "s3" {
    bucket       = "shahir143mithundevops"
    key          = "vpc/terraform.tfstate"
    region       = "ap-south-1"
    profile      = "terraformprofile"
    use_lockfile = true
  }
}