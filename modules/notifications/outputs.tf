output "notification_policy_id" {
  description = "The ID of the Grafana notification policy"
  value       = grafana_notification_policy.my_notification_policy.id
}