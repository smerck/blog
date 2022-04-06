module "blog_prod" {
  source = "./modules/digital_ocean/app"

  region = "nyc1"
  name = "blog"
  branch = "main" 
}


module "blog_test" {
  source = "./modules/digital_ocean/app"

  region = "nyc1"
  name = "blog-test"
  branch = "dev" 
}