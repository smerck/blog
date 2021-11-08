resource "digitalocean_domain" "smerc_io" {
    name = "smerc.io"     
}

resource "digitalocean_record" "blog_smerc_io" {
    type = "A"
    domain = digitalocean_domain.smerc_io.name
    name = "blog"
    value = "143.244.212.108" 
}

