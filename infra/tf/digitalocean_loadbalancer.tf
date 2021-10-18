resource "digitalocean_loadbalancer" "smerc_io_k8s" {
name =                      "smerc-k8s"
region = "nyc1"
    forwarding_rule {         
        entry_port      = 80         
        entry_protocol  = "tcp"         
        target_port     = 31421
        target_protocol = "tcp"         
        tls_passthrough = false     
    }
}
