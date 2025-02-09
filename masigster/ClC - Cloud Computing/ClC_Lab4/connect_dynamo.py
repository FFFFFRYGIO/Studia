import os
import boto3


AWS_ACCESS_KEY_ID = os.getenv("AWS_ACCESS_KEY_ID")
AWS_SECRET_ACCESS_KEY = os.getenv("AWS_SECRET_ACCESS_KEY")
AWS_REGION = os.getenv("AWS_REGION", "eu-central-1")

DYNAMO_TABLE_NAME = os.getenv("DYNAMO_TABLE_NAME")
DYNAMO_PARTITION_KEY = os.getenv("DYNAMO_PARTITION_KEY")


polly_client = boto3.client("polly", region_name=AWS_REGION)
dynamodb = boto3.resource("dynamodb", region_name=AWS_REGION)
table = dynamodb.Table(DYNAMO_TABLE_NAME)


def query_dynamo_db(key):

    table.put_item(Item={DYNAMO_PARTITION_KEY: key, 'value': '123value123' + key})

    response = table.get_item(Key={DYNAMO_PARTITION_KEY: key})

    print(response.get('Item'))


def synthesize_speech(text, output_filename):

    response = polly_client.synthesize_speech(
        Text=text,
        OutputFormat="mp3",
        VoiceId="Joanna",  # "Matthew", "Amy"
    )

    with open(output_filename, "wb") as file:
        file.write(response["AudioStream"].read())

    print(f"Saved as: {output_filename}")


def run_aws_polly(key):

    response = table.get_item(Key={DYNAMO_PARTITION_KEY: key})

    item = response.get("Item")
    if item:
        text_to_speak = item.get("value", "EMPTY")
        filename = f"output_{key}.mp3"
        synthesize_speech(text_to_speak, filename)
    else:
        print(f"Not found: {key}")


if __name__ == '__main__':

    for i in range(10):
        key = 'key' + str(i)
        query_dynamo_db(key)
        run_aws_polly(key)
