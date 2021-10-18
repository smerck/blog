terraform {
    required_providers {
        digitalocean = {
            source = "digitalocean/digitalocean"
            version = "~> 2.0"
        }
        kubernetes = {
            source = "hashicorp/kubernetes"
            version = ">= 2.0.0"
        }
    }
    backend "remote" {
        organization = "smerc"

        workspaces {
            name = "terraform-smercio-blog"
        }
    }

}

variable "do_token" {}

provider "digitalocean" {
    token = "${var.do_token}"
    }
