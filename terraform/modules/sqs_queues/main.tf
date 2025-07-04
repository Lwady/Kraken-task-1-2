# Create DLQs and add defaults
resource "aws_sqs_queue" "dlq" {
    for_each = { for name in var.queue_names : name => "${name}-dlq" }

    name = "${each.value}-dlq"

    message_retention_seconds  = var.dlq_message_retention_seconds
    visibility_timeout_seconds = var.dlq_visibility_timeout
}

# Create main queues with DLQs appended 
resource "aws_sqs_queue" "main" {
    for_each = toset(var.queue_names)

    name = each.value

    delay_seconds              = var.main_delay_time
    max_message_size           = var.main_maximum_message_size
    message_retention_seconds  = var.main_message_retention_seconds
    visibility_timeout_seconds = var.main_visibility_timeout
    receive_wait_time_seconds  = var.main_receive_wait_time
    redrive_policy = jsonencode({
        deadLetterTargetArn = aws_sqs_queue.dlq[each.value].arn
        maxReceiveCount     = var.main_redrive_max_receive_count  
    })
}

# IAM policy to receive and delete messages from SQS queues
resource "aws_iam_policy" "consume_policy" {
    name          = "sqs-consume-policy"
    description   = "Allow to receive and delete messages from SQS queues"
    policy        = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = [
                    "sqs:ReceiveMessage",
                    "sqs:DeleteMessage"
                ]
                Resource = concat (
                    [for q in values(aws_sqs_queue.main) : q.arn],
                    [for q in values(aws_sqs_queue.dlq) : q.arn]
                )

            }
        ]
    })
}

# IAM policy to allow sending messages to SQS queues 
resource "aws_iam_policy" "write_policy" {
    name      = "sqs-write-policy"
    description = "Allow sending messages to SQS queues"
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = [
                    "sqs:SendMessage"
                ]
                Resource = [for q in aws_sqs_queue.main : q.arn]
            }
        ]
    })
}

# IAM role for consume policy
resource "aws_iam_role" "consume_role" {
    count = var.create_roles ? 1 : 0

    name = "sqs-consume-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Principal = {
                    AWS = "*"
                }
                Action = "sts:AssumeRole"
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "consume_attachement" {
     count = var.create_roles ? 1 : 0
     role  = aws_iam_role.consume_role[0].name
     policy_arn = aws_iam_policy.consume_policy.arn
}

# IAM role for write policy
resource "aws_iam_role" "write_role" {
    count = var.create_roles ? 1 : 0

    name = "sqs-write-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Principal = {
                    AWS = "*"
                }
                Action = "sts:AssumeRole"
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "write_attachement" {
     count = var.create_roles ? 1 : 0
     role  = aws_iam_role.write_role[0].name
     policy_arn = aws_iam_policy.write_policy.arn
}