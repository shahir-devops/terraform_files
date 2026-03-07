module "thisec2" {
  source = "./modules/ec2"
  type = var.instance_type
  amiid = var.ami
}