"""
Subscriber that registers sensor values from qos=1
qos 1 (At Least One) is sending messages till he gets the confirmation
"""
import json

import paho.mqtt.client as mqtt

from fastapi_client import FastapiClient

fastapi_client = FastapiClient()


def on_connect(client, userdata, flags, reason_code, properties):
    print("Subscriber2 connected with result code " + str(reason_code))


def on_message(client, userdata, msg):
    print("Subscriber2 " + msg.topic + ": " + str(msg.payload) + ", qos = " + str(msg.qos))
    person_to_update = json.loads(msg.payload)

    response = fastapi_client.update_person(person_to_update)

    print(f"Repsonse: {response}")

    if response.status_code == 200:
        print(f"Response: {response.json()}")
    else:
        print(f"Error {response.status_code}: {response.text}")


client = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2)
client.on_connect = on_connect
client.on_message = on_message

client.connect("localhost", 1883, 60)

client.subscribe("people/update_person", qos=1)

try:
    print("Subscriber2 working...")
    client.loop_forever()
except KeyboardInterrupt:
    print("Subscriber2 shutdown")

client.disconnect()
