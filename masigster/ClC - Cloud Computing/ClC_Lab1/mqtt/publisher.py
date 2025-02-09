""" Publisher script that sends values to sensors """
import json
import time

import paho.mqtt.client as mqtt

client = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2)

client.connect("localhost", 1883, 60)

# qos 2
print("Publishing add_person with qos=2")
people_data = [
    {"first_name": "John", "last_name": "Doe", "age": 30, "email": "john.doe@example.com"},
    {"first_name": "Alice", "last_name": "Smith", "age": 25, "email": "alice.smith@example.com"},
    {"first_name": "Bob", "last_name": "Brown", "age": 40, "email": "bob.brown@example.com"},
]
for person_data in people_data:
    client.publish("people/add_person", payload=json.dumps(person_data), qos=2)

# qos 1
print("Publishing update_person with qos=1")
person_to_update = {"first_name": "John", "last_name": "Doe", "age": 30, "email": "john.doe.thesecond@example.com"}
client.publish("people/update_person", payload=json.dumps(person_to_update), qos=1)

# qos 0
print("Publishing get_all_people with qos=0")
client.publish("people/get_all_people", payload="get_all_people", qos=0)

client.loop_start()

time.sleep(2)

client.disconnect()
