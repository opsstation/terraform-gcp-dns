module "labels" {
  source      = "git::git@github.com:opsstation/terraform-gcp-labels.git?ref=v1.0.0"
  name        = var.name
  environment = var.environment
  label_order = var.label_order
  managedby   = var.managedby
  repository  = var.repository
}

data "google_client_config" "current" {
}

#####==============================================================================
##### A Response Policy is a collection of selectors that apply to queries made
###### against one or more Virtual Private Cloud networks.
#####==============================================================================
resource "google_dns_response_policy" "this" {
  project              = data.google_client_config.current.project
  response_policy_name = var.policy_name
  description          = var.description
  dynamic "networks" {
    for_each = var.network_self_links
    content {
      network_url = networks.value
    }
  }
}

#####==============================================================================
##### A Response Policy Rule is a selector that applies its behavior to queries that match the selector.
#####==============================================================================
resource "google_dns_response_policy_rule" "this" {
  for_each        = toset(keys(var.rules))
  provider        = google-beta
  project         = data.google_client_config.current.project
  rule_name       = each.key
  dns_name        = lookup(var.rules[each.key], "dns_name")
  response_policy = google_dns_response_policy.this.response_policy_name
  behavior        = lookup(var.rules[each.key], "rule_behavior", null)

  dynamic "local_data" {
    for_each = lookup(var.rules[each.key], "rule_behavior", "") == "bypassResponsePolicy" ? [] : [1]
    content {
      dynamic "local_datas" {
        for_each = lookup(var.rules[each.key], "rule_local_datas")
        content {
          name    = lookup(var.rules[each.key], "dns_name")
          rrdatas = local_datas.value.rrdatas
          ttl     = local_datas.value.ttl
          type    = local_datas.key
        }
      }
    }
  }
}