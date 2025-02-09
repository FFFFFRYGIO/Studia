import os

import requests

FASTAPI_PORT = int(os.getenv("FASTAPI_PORT", 8000))
FASTAPI_CONNECTION_PROTOCOL = os.getenv("FASTAPI_CONNECTION_PROTOCOL", 'http')


class FastapiClient:

    def __init__(self):
        self.url = f"{FASTAPI_CONNECTION_PROTOCOL}://fastapi_service:{FASTAPI_PORT}/"

    def add_person(self, person_data):
        add_url = self.url + "add_person/"
        return requests.post(add_url, json=person_data)

    def add_random_person(self):
        add_url = self.url + "add_random_person/"
        return requests.post(add_url)

    def update_person(self, person_to_update):
        add_url = self.url + "update_person/"
        return requests.put(add_url, json=person_to_update)

    def show_people(self):
        show_url = self.url + "get_all/"
        return requests.get(show_url)

    def show_people_first_names(self):
        show_url = self.url + "get_first_names/"
        return requests.get(show_url)
