import boto3
import json
import uuid
import os
from datetime import datetime

def lambda_handler(event, context):
    # Initialize clients
    sns_client = boto3.client('sns')
    dynamodb = boto3.resource('dynamodb')
    
    # References to SNS topic and DynamoDB table from environment variables
    topic_arn = os.environ['SNS_TOPIC_ARN']
    table_name = os.environ['DYNAMODB_TABLE']
    table = dynamodb.Table(table_name)
    
    # Get bucket name and object key from the event
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    object_key = event['Records'][0]['s3']['object']['key']
    
    # Check if the downloaded object is your CV
    if object_key == "Resume_Tamer_Ben.pdf": 
        # Create a unique ID and timestamp for the download event
        download_id = str(uuid.uuid4())
        timestamp = datetime.now().strftime("%d/%m/%Y")
        
        # Log download event to DynamoDB
        table.put_item(
            Item={
                'DownloadId': download_id,
                'DownloadDate': timestamp,
                'BucketName': bucket_name,
                'ObjectKey': object_key
            }
        )
        
        # Create a message for SNS notification
        message = f'Your CV {object_key} in bucket {bucket_name} has been downloaded.'
        
        # Publish message to SNS
        sns_client.publish(
            TopicArn=topic_arn,
            Message=message,
            Subject='CV Download Notification'
        )
    
        return {
            'statusCode': 200,
            'body': json.dumps('Notification sent and download logged successfully!')
        }
    else:
        return {
            'statusCode': 200,
            'body': json.dumps('Download logged, but it was not the CV.')
        }
