## Terraform-gcp-dns
## Terraform Google Cloud Dns Module
## Table of Contents

## Table of Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [Authors](#authors)
- [License](#license)

## Introduction
This project deploys a Google Cloud infrastructure using Terraform to create dns .

## Usage

To use this module, you should have Terraform installed and configured for GCP. This module provides the necessary Terraform configuration for creating GCP resources, and you can customize the inputs as needed. Below is an example of how to use this module:
# Example: _forwarding_

```hcl
module "dns_forwarding_zone" {
  source                             = "https://github.com/opsstation/terraform-gcp-dns.git"
  type                               = "forwarding"
  name                               = "app-test"
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

```
# Example: _peering_

```hcl
module "dns_peering_zone" {
  source                             = "https://github.com/opsstation/terraform-gcp-dns.git"
  type                               = "peering"
  name                               = "app-test"
  environment                        = "peering"
  domain                             = "foo.local."
  private_visibility_config_networks = [module.vpc.self_link]
  target_network                     = ""
  labels = {
    owner   = "foo"
    version = "bar"
  }
}

```
# Example: _private_

```hcl
module "dns_private_zone" {
  source                             = "https://github.com/opsstation/terraform-gcp-dns.git"
  type                               = "private"
  name                               = "app-test"
  environment                        = "dns-private-zone"
  domain                             = var.domain
  labels                             = var.labels
  private_visibility_config_networks = [module.vpc.self_link]

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

```
# Example: _public_

```hcl
module "dns_public_zone" {
  source                             = "https://github.com/opsstation/terraform-gcp-dns.git"
  type                               = "public"
  name                               = "app-test"
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

```
This example demonstrates how to create various GCP resources using the provided modules. Adjust the input values to suit your specific requirements.

## Module Inputs

- `name`: The name of the application or resource.
- `environment`: The environment in which the resource exists.
- `label_order`: The order in which labels should be applied.
- `business_unit`: The business unit associated with the application.
- `attributes`: Additional attributes to add to the labels.
- `extra_tags`: Extra tags to associate with the resource.

## Module Outputs
- This module currently does not provide any outputs.

# Examples
For detailed examples on how to use this module, please refer to the [example](https://github.com/opsstation/terraform-gcp-dns/tree/master/_example) directory within this repository.

## Authors
Your Name
Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/opsstation/terraform-gcp-dns/blob/master/LICENSE) file for details.



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.75, < 5.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 4.75, < 5.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.75, < 5.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | >= 4.75, < 5.13.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | git::git@github.com:opsstation/terraform-gcp-labels.git | v1.0.0 |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_dns_managed_zone.forwarding](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_dns_managed_zone) | resource |
| [google-beta_google_dns_managed_zone.peering](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_dns_managed_zone) | resource |
| [google-beta_google_dns_managed_zone.reverse_lookup](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_dns_managed_zone) | resource |
| [google-beta_google_dns_managed_zone.service_directory](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_dns_managed_zone) | resource |
| [google_dns_managed_zone.private](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone) | resource |
| [google_dns_managed_zone.public](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone) | resource |
| [google_dns_record_set.cloud-static-records](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_client_config.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_key_specs_key"></a> [default\_key\_specs\_key](#input\_default\_key\_specs\_key) | Object containing default key signing specifications : algorithm, key\_length, key\_type, kind. Please see https://www.terraform.io/docs/providers/google/r/dns_managed_zone#dnssec_config for futhers details | `any` | `{}` | no |
| <a name="input_default_key_specs_zone"></a> [default\_key\_specs\_zone](#input\_default\_key\_specs\_zone) | Object containing default zone signing specifications : algorithm, key\_length, key\_type, kind. Please see https://www.terraform.io/docs/providers/google/r/dns_managed_zone#dnssec_config for futhers details | `any` | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | zone description (shown in console) | `string` | `"Managed by opsstation"` | no |
| <a name="input_dnssec_config"></a> [dnssec\_config](#input\_dnssec\_config) | Object containing : kind, non\_existence, state. Please see https://www.terraform.io/docs/providers/google/r/dns_managed_zone#dnssec_config for futhers details | `any` | `{}` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Zone domain, must end with a period. | `string` | n/a | yes |
| <a name="input_enable_logging"></a> [enable\_logging](#input\_enable\_logging) | Enable query logging for this ManagedZone | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Set this true to delete all records in the zone. | `bool` | `false` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] . | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to this ManagedZone | `map(any)` | `{}` | no |
| <a name="input_managedby"></a> [managedby](#input\_managedby) | ManagedBy,opsstation | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the resource. Provided by the client when the resource is created. | `string` | `"test"` | no |
| <a name="input_private_visibility_config_networks"></a> [private\_visibility\_config\_networks](#input\_private\_visibility\_config\_networks) | List of VPC self links that can see this zone. | `list(any)` | `[]` | no |
| <a name="input_recordsets"></a> [recordsets](#input\_recordsets) | List of DNS record objects to manage, in the standard terraform dns structure. | <pre>list(object({<br>    name    = string<br>    type    = string<br>    ttl     = number<br>    records = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Terraform current module repo | `string` | `""` | no |
| <a name="input_service_namespace_url"></a> [service\_namespace\_url](#input\_service\_namespace\_url) | The fully qualified or partial URL of the service directory namespace that should be associated with the zone. This should be formatted like https://servicedirectory.googleapis.com/v1/projects/{project}/locations/{location}/namespaces/{namespace_id} or simply projects/{project}/locations/{location}/namespaces/{namespace\_id}. | `string` | `""` | no |
| <a name="input_target_name_server_addresses"></a> [target\_name\_server\_addresses](#input\_target\_name\_server\_addresses) | List of target name servers for forwarding zone. | `list(map(any))` | `[]` | no |
| <a name="input_target_network"></a> [target\_network](#input\_target\_network) | Peering network. | `string` | `""` | no |
| <a name="input_type"></a> [type](#input\_type) | Type of zone to create, valid values are 'public', 'private', 'forwarding', 'peering', 'reverse\_lookup' and 'service\_directory'. | `string` | `"private"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_creation_time"></a> [creation\_time](#output\_creation\_time) | The time that this resource was created on the server. |
| <a name="output_domain"></a> [domain](#output\_domain) | The DNS zone domain. |
| <a name="output_managed_zone_id"></a> [managed\_zone\_id](#output\_managed\_zone\_id) | An identifier for the resource with format. |
| <a name="output_name"></a> [name](#output\_name) | The DNS zone name. |
| <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers) | The DNS zone name servers. |
| <a name="output_type"></a> [type](#output\_type) | The DNS zone type. |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | An identifier for the resource with format. |
<!-- END_TF_DOCS -->