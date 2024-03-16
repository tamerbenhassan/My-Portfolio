import os
import boto3
import time

def create_invalidation(distribution_id, paths):
    client = boto3.client('cloudfront')
    caller_reference = str(time.time()).replace(".", "")
    invalidation_batch = {
        'Paths': {
            'Quantity': len(paths),
            'Items': paths
        },
        'CallerReference': caller_reference
    }

    response = client.create_invalidation(
        DistributionId=distribution_id,
        InvalidationBatch=invalidation_batch
    )
    return response

if __name__ == "__main__":
    distribution_id = os.environ.get('CLOUDFRONT_DISTRIBUTION_ID')
    if not distribution_id:
        raise ValueError("The CLOUDFRONT_DISTRIBUTION_ID environment variable is not set.")
    
    paths = ['/*']
    try:
        response = create_invalidation(distribution_id, paths)
        print("Invalidation created:", response)
    except Exception as e:
        print("An error occurred:", e)
