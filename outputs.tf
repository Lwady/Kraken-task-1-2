output "queue_arns" {
  description = "Queue ARNs from sqs_queues module"
  value       = module.sqs_queues.queue_arns
}

output "consume_policy_arn" {
  description = "Consume policy ARN from sqs_queues module"
  value       = module.sqs_queues.consume_policy_arn
}

output "write_policy_arn" {
  description = "Write policy ARN from sqs_queues module"
  value       = module.sqs_queues.write_policy_arn
}

output "consume_role_arn" {
  description = "Consume role ARN from sqs_queues module"
  value       = module.sqs_queues.consume_role_arn
}

output "write_role_arn" {
  description = "Write role ARN from sqs_queues module"
  value       = module.sqs_queues.write_role_arn
}