variable "queue_names" {
    type        = list(string)
    description = "List of SQS queue names to be created. DLQs to be created automatically"
}

variable "create_roles" {
    type        = bool
    default     = false
    description = "Create IAM role for generated policies"
}

variable "dlq_message_retention_seconds" {
    type        = number
    default     = 1209600
    description = "14 days (maximum) for debugging time if required"
}

variable "dlq_visibility_timeout" {
    type        = number
    default     = 30
    description = "Visibility timeout for DLQs"
}

variable "main_message_retention_seconds" {
    type        = number
    default     = 345600
    description = "Main message retention for 4 days"
}

variable "main_visibility_timeout" {
    type        = number
    default     = 60
    description = "Main queue visibility timeout"
}

variable "main_receive_wait_time" {
    type        = number
    default     = 20
    description = "Main queue receive wait time"
}

variable "main_delay_time" {
    type        = number
    default     = 90
    description = "Main queue delivery delay"
}

variable "main_maximum_message_size" {
    type        = number
    default     = 262144
    description = "Maximum message size in bytes"
}

variable "main_redrive_max_receive_count" {
    type        = number
    default     = 4
    description = "Maximum count before moving to DLQ"
}