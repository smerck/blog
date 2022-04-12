data "digitalocean_domain" "smerc_io" {
  name = "smerc.io"
}

data "digitalocean_domain" "smerc_dev" {
  name = "smerc.dev"
}


locals {
  mx_records = [
    {
      name     = "mx"
      value    = "gmr-smtp-in.l.google.com."
      priority = "1"
    },
    {
      name     = "mx1"
      value    = "alt1.gmr-smtp-in.l.google.com."
      priority = "5"
    },
    {
      name     = "mx2"
      value    = "alt2.gmr-smtp-in.l.google.com."
      priority = "5"
    },
    {
      name     = "mx3"
      value    = "alt3.gmr-smtp-in.l.google.com."
      priority = "10"
    },
    {
      name     = "mx4"
      value    = "alt4.gmr-smtp-in.l.google.com."
      priority = "10"
    },
  ]
}

resource "digitalocean_record" "mx_smerc_io" {
  for_each = { for record in local.mx_records : record.name => record }
  domain   = data.digitalocean_domain.smerc_io.id
  type     = "MX"
  name     = "@"
  value    = each.value.value
  priority = each.value.priority
}


resource "digitalocean_record" "mx_smerc_dev" {
  for_each = { for record in local.mx_records : record.name => record }
  domain   = data.digitalocean_domain.smerc_dev.id
  type     = "MX"
  name     = "@"
  value    = each.value.value
  priority = each.value.priority
}
