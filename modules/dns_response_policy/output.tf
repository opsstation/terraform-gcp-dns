output "response_policy_id" {
  description = "An identifier for the resource with format projects/{{project}}/responsePolicies/{{response_policy_name}}."
  value       = google_dns_response_policy.this.id
}

output "response_policy_rule_ids" {
  description = "List of response rules with format projects/{{project}}/responsePolicies/{{response_policy}}/rules/{{rule_name}}."
  value       = [for rule in google_dns_response_policy_rule.this : rule.id]
}