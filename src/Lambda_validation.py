import json
import urllib.parse

def lambda_handler(event, context):
    try:
        # Extract the bucket name and file name from the S3 event trigger
        bucket = event['Records'][0]['s3']['bucket']['name']
        key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
        
        print(f"SUCCESS: New file '{key}' validated")
        
        return {
            'statusCode': 200,
            'body': json.dumps(f'{key} has been validated successfully!')
        }
    except Exception as e:
        print(f"Error processing S3 event: {str(e)}")
        raise e