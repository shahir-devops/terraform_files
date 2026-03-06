module "prod" {
  source  = "../02-basic codes for modules"
  amiid   = "ami-051a31ab2f4d498f5"
  type    = "t2.nano"
  keyname = "shahir"

}