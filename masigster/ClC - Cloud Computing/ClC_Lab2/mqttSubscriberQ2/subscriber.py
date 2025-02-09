import json
import os
import time

import paho.mqtt.client as mqtt

from fastapi_client import FastapiClient

MQTT_BROCKER_NAME = os.getenv("MQTT_BROCKER_NAME", "mqtt_broker")
MQTT_PORT = int(os.getenv("MQTT_PORT", 1883))
MQTT_KEEPALIVE_TIME = int(os.getenv("MQTT_KEEPALIVE_TIME", 60))

time.sleep(2)

fastapi_client = FastapiClient()


def on_connect(client, userdata, flags, reason_code, properties):
    print("SubscriberQ2 connected with result code " + str(reason_code))


def on_message(client, userdata, msg):
    print("SubscriberQ2 " + msg.topic + ": " + str(msg.payload) + ", qos = " + str(msg.qos))

    if msg.payload.decode('utf-8') == "add_random_person":
        response = fastapi_client.add_random_person()

    else:
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

client.connect(MQTT_BROCKER_NAME, MQTT_PORT, MQTT_KEEPALIVE_TIME)

client.subscribe("people/add_person", qos=2)

try:
    print("SubscriberQ2 working...")
    client.loop_forever()
except KeyboardInterrupt:
    print("SubscriberQ2 shutdown")

client.disconnect()
