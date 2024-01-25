provider "google" {
  project = "local-concord-408802"
  region  = "asia-northeast1"
  zone    = "asia-northeast1-a"
}

#####==============================================================================
##### vpc module call.
#####==============================================================================
module "vpc" {
  source                                    = "git::git@github.com:opsstation/terraform-gcp-vpc.git?ref=v1.0.0"
  name                                      = "dev"
  environment                               = "test"
  label_order                               = ["name", "environment"]
  mtu                                       = 1460
  routing_mode                              = "REGIONAL"
  google_compute_network_enabled            = true
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
  delete_default_routes_on_create           = false
}

#####==============================================================================
##### dns-forwarding-zone module call.
#####==============================================================================
module "dns_forwarding_zone" {
  source                             = "../.."
  type                               = "forwarding"
  name                               = "dev-test"
  environment                        = "forwarding"
  domain                             = var.domain
  labels                             = var.labels
  private_visibility_config_networks = [module.vpc.self_link]
  target_name_server_addresses = [
    {
      ipv4_address    = "8.8.8.8",
      forwarding_path = "default"
    },
    {
      ipv4_address    = "8.8.4.4",
      forwarding_path = "default"
    }
  ]
}