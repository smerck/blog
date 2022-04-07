module "blog_prod" {
  source = "./modules/digital_ocean/app"

  region = "nyc1"
  name = "smerc-blog"
  branch = "main"
}
