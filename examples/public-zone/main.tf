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
##### dns-public-zone module call.
#####==============================================================================
module "dns_public_zone" {
  source                             = "../.."
  type                               = "public"
  name                               = "dev-test"
  environment                        = "public"
  domain                             = var.domain
  labels                             = var.labels
  private_visibility_config_networks = [module.vpc.self_link]
  enable_logging                     = true

  recordsets = [
    {
      name = "ns"
      type = "A"
      ttl  = 300
      records = [
        "127.0.0.1",
      ]
    },
    {
      name = ""
      type = "NS"
      ttl  = 300
      records = [
        "ns.${var.domain}",
      ]
    },
    {
      name = "localhost"
      type = "A"
      ttl  = 300
      records = [
        "127.0.0.1",
      ]
    },
    {
      name = ""
      type = "MX"
      ttl  = 300
      records = [
        "1 localhost.",
      ]
    },
    {
      name = ""
      type = "TXT"
      ttl  = 300
      records = [
        "\"v=spf1 -all\"",
      ]
    },
  ]
}