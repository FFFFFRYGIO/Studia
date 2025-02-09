import json
import os
import requests

URL = os.getenv("STAGE_URL")

def add_record(key, value):

    url = URL + os.getenv("ADD_RECORD_ENDPOINT")

    payload = {
        os.getenv("DYNAMO_PARTITION_KEY"): key,
        "value": "value"
    }

    headers = {'content-type': 'application/json'}

    try:
        response = requests.post(url, data=json.dumps(payload), headers=headers)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.HTTPError as e:
        print('Http Error')
        print(e)

    return None


def get_record(key):

    url = URL + os.getenv("GET_RECORD_ENDPOINT")

    payload = {os.getenv("DYNAMO_PARTITION_KEY"): key}

    headers = {'content-type': 'application/json'}

    try:
        response = requests.post(url, data=json.dumps(payload), headers=headers)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.HTTPError as e:
        print('Http Error')
        print(e)

    return None


if __name__ == '__main__':
    key = 'local_sample_key'
    value = 'local_sample_value'

    print(add_record(key, value))
    print(get_record(key))
