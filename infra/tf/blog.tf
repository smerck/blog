module "blog_dev" {
  source = "./modules/digital_ocean/app"

  region      = "nyc"
  name        = "smerc-dev-blog"
  branch      = "main"
  apex_domain = "smerc.dev"

}
