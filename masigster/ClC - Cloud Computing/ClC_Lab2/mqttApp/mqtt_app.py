""" Publisher script that sends values to sensors """
import json
import os
import time

import paho.mqtt.client as mqtt

MQTT_BROCKER_NAME = os.getenv("MQTT_BROCKER_NAME", "mqtt_broker")
MQTT_PORT = int(os.getenv("MQTT_PORT", 1883))
MQTT_KEEPALIVE_TIME = int(os.getenv("MQTT_KEEPALIVE_TIME", 60))

time.sleep(10)

client = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2)

client.connect(MQTT_BROCKER_NAME, MQTT_PORT, MQTT_KEEPALIVE_TIME)

# qos 0
print("Publishing get_all_people with qos=0")
client.publish("people/get_all_people", payload="get_all_people", qos=0)
time.sleep(1)

# qos 2
print("Publishing add_person with qos=2")
people_data = [
    {"first_name": "Alice", "last_name": "Smith", "age": 25, "email": "alice.smith@example.com"},
    {"first_name": "Bob", "last_name": "Brown", "age": 40, "email": "bob.brown@example.com"},
    {"first_name": "Cecile", "last_name": "Bracket", "age": 30, "email": "cecile.bracket@example.com"},
]
for person_data in people_data:
    client.publish("people/add_person", payload=json.dumps(person_data), qos=2)
    time.sleep(1)

# qos 2
print("Publishing add_person, but random with qos=2")
for person_data in people_data:
    client.publish("people/add_person", payload="add_random_person", qos=2)
    time.sleep(1)

# qos 1
print("Publishing update_person with qos=1")
person_to_update = {"first_name": "John", "last_name": "Doe", "age": 30, "email": "john.doe@example.com"}
client.publish("people/update_person", payload=json.dumps(person_to_update), qos=1)
time.sleep(1)

# qos 0
print("Publishing get_people, but all with qos=0")
client.publish("people/get_people", payload="get_all_people", qos=0)
time.sleep(1)

# qos 0
print("Publishing get_people, but for first names with qos=0")
client.publish("people/get_people", payload="get_first_names", qos=0)
time.sleep(1)

client.loop_start()

time.sleep(2)

client.disconnect()

print('Publisher finished')
