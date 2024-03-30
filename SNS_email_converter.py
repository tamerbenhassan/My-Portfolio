import json
import boto3
from datetime import datetime

def lambda_handler(event, context):
    # Parse the JSON message
    message = json.loads(event['Records'][0]['Sns']['Message'])
    
    # Extract relevant information
    pipeline_name = message['detail']['pipeline']
    state = message['detail']['state']
    action = message['detail']['action']
    time = datetime.strptime(message['time'], '%Y-%m-%dT%H:%M:%SZ')
    
    # Convert time to a more readable format
    time_str = time.strftime('%Y-%m-%d %H:%M:%S')
    
    # Construct the email body
    email_body = (
        f"Pipeline Name: {pipeline_name}\n"
        f"Action: {action}\n"
        f"State: {state}\n"
        f"Time: {time_str}\n"
    )
    
    # Specify the sender and recipient
    sender = "tamer.benhassan@outlook.com"
    recipient = "tamer.benhassan@outlook.com"

    # The subject line for the email.
    subject = f"Update on {pipeline_name} Pipeline Execution"

    # The character encoding for the email.
    charset = "UTF-8"

    # Create a new SES resource 
    ses_client = boto3.client('ses')

    # Try to send the email.
    try:
        response = ses_client.send_email(
            Destination={
                'ToAddresses': [recipient],
            },
            Message={
                'Body': {
                    'Text': {
                        'Charset': charset,
                        'Data': email_body,
                    },
                },
                'Subject': {
                    'Charset': charset,
                    'Data': subject,
                },
            },
            Source=sender,
        )
    # Display an error if something goes wrong.	
    except Exception as e:
        print(f"Error sending email: {e}")
        raise e
    else:
        print(f"Email sent! Message ID: {response['MessageId']}")

    return {
        'statusCode': 200,
        'body': json.dumps('Lambda executed successfully!')
    }
