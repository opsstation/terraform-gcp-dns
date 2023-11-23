provider "google" {
  project = "opz0-397319"
  region  = "asia-northeast1"
  zone    = "asia-northeast1-a"
}

#####==============================================================================
##### vpc module call.
#####==============================================================================
module "vpc" {
  source                                    = "git::git@github.com:opsstation/terraform-gcp-vpc.git?ref=master"
  name                                      = "app"
  environment                               = "test"
  routing_mode                              = "REGIONAL"
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
}

#####==============================================================================
##### dns_response_policy module call.
#####==============================================================================
module "dns_response_policy" {
  source             = "../../modules/dns_response_policy"
  policy_name        = "dns-test"
  name               = "app-test"
  environment        = "response-policy"
  network_self_links = [module.vpc.self_link]
  description        = "Example DNS response policy created by terraform module OpsStation."

  rules = {
    "override-google-com" = {
      dns_name = "*.google.com."
      rule_local_datas = {
        "A" = { # Record type.
          rrdatas = ["192.0.2.91"]
          ttl     = 300
        },
        "AAAA" = {
          rrdatas = ["2001:db8::8bd:1002"]
          ttl     = 300
        }
      }
    },
    "override-withgoogle-com" = {
      dns_name = "withgoogle.com."
      rule_local_datas = {
        "A" = {
          rrdatas = ["193.0.2.93"]
          ttl     = 300
        }
      }
    },
    "bypass-google-account-domain" = {
      dns_name      = "account.google.com."
      rule_behavior = "bypassResponsePolicy"
    }
  }
}