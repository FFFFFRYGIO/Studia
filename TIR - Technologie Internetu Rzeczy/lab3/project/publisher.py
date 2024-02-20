import sys
import paho.mqtt.client as mqtt


mqtt_client = mqtt.Client()

if mqtt_client.connect("mqttBroker") != 0:
    print("Couldn't connect to the mqtt broker")
    sys.exit(1)

for i in range(3):
    print(f"Publish number {i + 1}")
    mqtt_client.publish("add_person")

mqtt_client.loop_forever()
