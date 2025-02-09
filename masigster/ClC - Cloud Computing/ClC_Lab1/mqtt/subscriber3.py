"""
Subscriber that registers sensor values from qos=2
qos 2 (Exactly One) is sending one message and looks for confirmation
"""

import paho.mqtt.client as mqtt

from fastapi_client import FastapiClient

fastapi_client = FastapiClient()


def on_connect(client, userdata, flags, reason_code, properties):
    print("Subscriber3 connected with result code " + str(reason_code))


def on_message(client, userdata, msg):
    print("Subscriber3 " + msg.topic + ": " + str(msg.payload) + ", qos = " + str(msg.qos))

    response = fastapi_client.show_people()

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

client.connect("localhost", 1883, 60)

client.subscribe("people/get_all_people", qos=0)

try:
    print("Subscriber3 working...")
    client.loop_forever()
except KeyboardInterrupt:
    print("Subscriber3 shutdown")

client.disconnect()
