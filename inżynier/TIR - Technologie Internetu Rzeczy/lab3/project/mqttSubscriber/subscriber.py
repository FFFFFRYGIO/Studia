import sys

import paho.mqtt.client as mqtt


def connect_handling(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))
    client.subscribe("parse_add_person")


def message_handling(client, userdata, msg):
    print(f"Received message on topic: {msg.topic}: {msg.payload.decode()}")


client = mqtt.Client()
client.on_connect = connect_handling
client.on_message = message_handling


if client.connect("mqtt_broker", 1883, 60) != 0:
    print("Couldn't connect to the mqtt broker")
    sys.exit(1)

client.loop_forever()
