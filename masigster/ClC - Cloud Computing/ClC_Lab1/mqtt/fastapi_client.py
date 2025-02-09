import requests


class FastapiClient:

    def __init__(self):
        self.url = "http://127.0.0.1:8000/"

    def add_person(self, person_data):
        add_url = self.url + "add_person/"
        return requests.post(add_url, json=person_data)

    def update_person(self, person_to_update):
        add_url = self.url + "update_person/"
        return requests.put(add_url, json=person_to_update)

    def show_people(self):
        show_url = self.url + "get_all/"
        return requests.get(show_url)
