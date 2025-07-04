## Kraken SQS Task

This project contains:
1. A **Python script** to fetch and display the message count in SQS queues and their Dead Letter Queues.

Compatible with Python 3.8+

### Prerequisites
- Python 3.8+ installed
- Use a virtual environment (recommended)

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
