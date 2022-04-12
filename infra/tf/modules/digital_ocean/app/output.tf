output "app_url" {
  value = digitalocean_app.app.live_url
}

output "do_url" {
  value = digitalocean_app.app.default_ingress
}
