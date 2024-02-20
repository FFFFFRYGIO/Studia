import sys
import paho.mqtt.client as mqtt
import requests


def connect_handling(client, userdata, flags, rc):
    print("Connected with return code:" + str(rc))
    client.subscribe("add_person")


def message_handling(client, userdata, msg):
    print(f"Received message on topic: {msg.topic}: {msg.payload.decode()}")

    response = requests.post("http://fastapi:8000/add_random_person")
    data = response.json()
    client.publish("data_from_fastapi", str(data), qos=0)

    response = requests.get("http://fastapi:8000/get_all")
    data = response.json()
    client.publish("parse_add_person", str(data), qos=0)


mqtt_client = mqtt.Client()
mqtt_client.on_connect = connect_handling
mqtt_client.on_message = message_handling

if mqtt_client.connect("mqttBroker") != 0:
    print("Couldn't connect to the mqtt broker")
    sys.exit(1)

mqtt_client.loop_forever()
