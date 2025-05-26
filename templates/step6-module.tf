module "dev" {
  source = "./module/myinfra"
  environment = "dev"
}
module "pro" {
  source = "./module/myinfra"
  environment = "pro"
}