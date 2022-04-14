resource "digitalocean_app" "app" {
  spec {
    name   = var.name
    region = var.region

    domain {
      name = var.apex_domain
      type = "PRIMARY"
      zone = var.apex_domain
      wildcard = true
    }

    service {
      name               = var.name
      instance_count     = 1
      instance_size_slug = "basic-xxs"
      dockerfile_path    = "Dockerfile"
      http_port          = 1313


      routes {
        path = "/"
      }

      github {
        repo           = "smerck/blog"
        branch         = var.branch
        deploy_on_push = true
      }

      health_check {
        http_path = "/"
      }

      cors {
        allow_origins {
          regex = ".*"
        }
      }
      source_dir = "/"
    }
  }
}
