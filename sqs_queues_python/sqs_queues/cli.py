import argparse
import json
from . import get_queues_message_totals

def _parse_args():
    parser = argparse.ArgumentParser(
        description="Fetch message counts from SQS queus and their DLQs"
    )
    parser.add_argument("queues", nargs="+", help="Queue names")
    parser.add_argument("--json", action="store_true", help="Output in JSON format")
    return parser.parse_args()

def main():
    args = _parse_args()
    results = get_queues_message_totals(args.queues)

    if args.json:
        print(json.dumps(results, indent=2))
    else:
        for q, count in results.items():
            print(f"{q}: {count}")