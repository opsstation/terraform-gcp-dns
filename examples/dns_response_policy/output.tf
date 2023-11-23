output "response_policy_id" {
  description = "An identifier for the resource with format projects/{{project}}/responsePolicies/{{response_policy_name}}."
  value       = module.dns_response_policy.response_policy_id
}

output "response_policy_rule_ids" {
  description = "List of response rules with format projects/{{project}}/responsePolicies/{{response_policy}}/rules/{{rule_name}}."
  value       = module.dns_response_policy.response_policy_rule_ids
}