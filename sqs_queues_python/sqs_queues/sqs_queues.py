import boto3
import botocore.exceptions
from typing import List, Dict
import logging
import sys

logging.basicConfig(stream=sys.stderr, level=logging.INFO)
logger = logging.getLogger(__name__)

def list_sqs_queues():
    sqs = boto3.client("sqs", region_name="eu-west-2")
    response = sqs.list_queues()

    print("SQS Queues:")
    for url in response.get("QueueUrls", []):
        print(f" - {url}")

def get_queue_message_count(queue_name: str) -> int:
    """
    Return approximate number of messages in SQS queue
    """
    sqs = boto3.client("sqs", region_name="eu-west-2")
    try:
        url = sqs.get_queue_url(QueueName=queue_name)["QueueUrl"]
        attrs = sqs.get_queue_attributes(
            QueueUrl=url,
            AttributeNames=["ApproximateNumberOfMessages"]
        )
        return int(attrs["Attributes"]["ApproximateNumberOfMessages"])
    except botocore.exceptions.ClientError as e:
        logger.error(f"Error fetching queue '{queue_name}': {e}")
        return -1
    except Exception as e:
        logger.error(f"Unexpected error: {e}")
        return -1
    
def get_queues_message_totals(queue_names: List[str]) -> Dict[str, int]:
    """
    Return message count for their queues and DLQs
    """
    results: Dict[str, int] = {}
    for name in queue_names:
        results[name] = get_queue_message_count(name)
        results[f"{name}-dlq"] = get_queue_message_count(f"{name}-dlq")
    return results