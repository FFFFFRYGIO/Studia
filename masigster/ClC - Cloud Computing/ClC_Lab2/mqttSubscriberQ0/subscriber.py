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
    print("SubscriberQ0 connected with result code " + str(reason_code))


def on_message(client, userdata, msg):
    print("SubscriberQ0 " + msg.topic + ": " + str(msg.payload) + ", qos = " + str(msg.qos))

    if msg.payload.decode('utf-8') == "get_all_people":
        response = fastapi_client.show_people()

    elif msg.payload.decode('utf-8') == "get_first_names":
        response = fastapi_client.show_people_first_names()

    else:
        print(f"Error, wrong get qos 0 message: {msg.payload}")

    print(f"Repsonse: {response}")

    if response.status_code == 200:
        print(f"Response: {response.json()}")
        print()
        print("All people:")
        for person in response.json():
            print(person)
    else:
        print(f"Error {response.status_code}: {response.text}")


client = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2)
client.on_connect = on_connect
client.on_message = on_message

client.connect(MQTT_BROCKER_NAME, MQTT_PORT, MQTT_KEEPALIVE_TIME)

client.subscribe("people/get_people", qos=0)

try:
    print("SubscriberQ0 working...")
    client.loop_forever()
except KeyboardInterrupt:
    print("SubscriberQ0 shutdown")

client.disconnect()
