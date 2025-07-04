## Kraken SQS Task

This project contains:
1. A **Terraform module** to create SQS queues with attached Dead Letter Queues and IAM policies and roles.


Compatible with Terraform v1.0+, AWS Provider v3.48.0+ and Python 3.8+

### Prerequisites
- AWS CLI configured
- Terraform v1.0+


### Terraform: Create SQS Queues and IAM Policies

Make sure you are in modules/sqs_queues

run:
```bash
terraform init
terraform plan
terraform apply
```
