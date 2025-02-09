"""
Subscriber that registers sensor values from qos=0
qos 0 (Zero Assurance) is not checking if the receiver got the message
"""
import json

import paho.mqtt.client as mqtt

from fastapi_client import FastapiClient

fastapi_client = FastapiClient()


def on_connect(client, userdata, flags, reason_code, properties):
    print("Subscriber1 connected with result code " + str(reason_code))


def on_message(client, userdata, msg):
    print("Subscriber1 " + msg.topic + ": " + str(msg.payload) + ", qos = " + str(msg.qos))
    person_data = json.loads(msg.payload)

    response = fastapi_client.add_person(person_data)

    print(f"Repsonse: {response}")

    if response.status_code == 200:
        print(f"Response: {response.json()}")
    else:
        print(f"Error {response.status_code}: {response.text}")


client = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2)
client.on_connect = on_connect
client.on_message = on_message

client.connect("localhost", 1883, 60)

client.subscribe("people/add_person", qos=2)

try:
    print("Subscriber1 working...")
    client.loop_forever()
except KeyboardInterrupt:
    print("Subscriber1 shutdown")

client.disconnect()
