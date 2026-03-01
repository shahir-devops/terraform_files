terraform {
  backend "s3" {
    bucket       = "shahir143mithundevops"
    key          = "output/terraform.tfstate"
    region       = "ap-south-1"
    profile      = "terraformprofile"
    use_lockfile = true
  }
}