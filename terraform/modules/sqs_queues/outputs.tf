output "queue_arns" {
    description = "ARNs of all SQS queues"
    value = concat(
        [for q in values(aws_sqs_queue.main) : q.arn],
        [for q in values(aws_sqs_queue.dlq) : q.arn]
    )
}

output "consume_policy_arn" {
    description = "ARN of the consume IAM policy"
    value       = aws_iam_policy.consume_policy.arn
}

output "write_policy_arn" {
    description = "ARN of the write IAM policy"
    value       = aws_iam_policy.write_policy.arn
}

output "consume_role_arn" {
    description = "ARN of the consume IAM role"
    value       = var.create_roles ? aws_iam_role.consume_role[0].arn : null
}

output "write_role_arn" {
    description = "ARN of the write IAM role"
    value       = var.create_roles ? aws_iam_role.write_role[0].arn : null
}