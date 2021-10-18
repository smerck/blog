variable "do_cluster_name" {}

resource "digitalocean_kubernetes_cluster" "smerc_dev" {
    name = "${var.do_cluster_name}"
    region = "nyc1"
    version = "1.21.3-do.0"

    node_pool {
        name = "worker-pool"
        size = "s-2vcpu-2gb"
        node_count = 2
    }
}

output "cluster-id" {
    value = "${digitalocean_kubernetes_cluster.smerc_dev.id}"
}
