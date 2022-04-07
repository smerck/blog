module "blog_prod" {
  source = "./modules/digital_ocean/app"

  region = "nyc"
  name = "smerc-blog"
  branch = "main"
  hostname = "blog.smerc.io"
}
