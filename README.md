## Kraken SQS Task

This project contains:
1. A **Terraform module** to create SQS queues with attached Dead Letter Queues and IAM policies and roles.
2. A **Python script** to fetch and display the message count in SQS queues and their Dead Letter Queues.

Compatible with Terraform v1.0+, AWS Provider v3.48.0+ and Python 3.8+

### Prerequisites
- AWS CLI configured
- Terraform v1.0+
- Python 3.8+ installed
- Use a virtual environment (recommended)

#### Directory structure

```
KRAKEN-TASK-1+2/
├── .terraform/
├── .venv/
├── .gitignore
├── main.tf
├── outputs.tf
├── README.md
├── requirements.txt
├── terraform.lock.hcl
├── terraform.tfstate
├── terraform.tfstate.backup
├── sqs_queues/
│   ├── main.tf
│   ├── outputs.tf
│   ├── variables.tf
│   ├── versions.tf
│   └── README.md
└── sqs_queues_python/
    ├── sqs_queues/
    │   ├── __init__.py
    │   ├── __main__.py
    │   ├── cli.py
    │   └── sqs_queues.py
    └── __pycache__/
```
### Terraform: Create SQS Queues and IAM Policies

Make sure you are in the root of Kraken-task-1+2

run:
```bash
terraform init
terraform plan
terraform apply
```

### Python Script - View message counts
This uses boto3 to dsiplay how many messages are in each queue and its Dead Letter Queue.

Run as CLI

#### Requirements
- Python 3.8+
- Virtual environment
- AWS credentials (same as Terraform)

1. From root of directory create and activate virtual environment

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python -m sqs_queues_python.sqs_queues priority-10 priority-100 --json
```
