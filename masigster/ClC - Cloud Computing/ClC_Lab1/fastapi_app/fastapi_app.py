import random

from fastapi import FastAPI, HTTPException

import fastapi_database_app as db
from person import Person

app = FastAPI()


def validate_person_data(person_data):
    return set(Person.__fields__.keys()) == set(person_data.keys())


@app.get("/get_first_names")
def get_data1():
    result = db.get_data_from_db()
    return [row[1] for row in result]


@app.get("/get_emails")
def get_data2():
    result = db.get_data_from_db()
    return [row[3] for row in result]


@app.get("/get_all")
def get_data3():
    result = db.get_data_from_db()
    return result


@app.post("/add_person/")
def add_person(person: Person):
    if validate_person_data(person):
        return db.add_data_to_db(person)
    else:
        return HTTPException(
            status_code=400,
            detail="Invalid data. Ensure all required fields are provided."
        )


@app.post("/add_random_person")
def add_random_person():
    first_names = ["A", "B", "C"]
    last_names = ["AA", "BB", "CC"]

    first_name = random.choice(first_names)
    last_name = random.choice(last_names)
    age = random.randint(18, 60)
    email = f"{first_name}.{last_name}@gmail.com"

    person = Person()
    person.first_name = first_name
    person.last_name = last_name
    person.age = age
    person.email = email

    # db.add_data_to_db(person)
    return db.add_data_to_db(person)


@app.put("/update_person/")
def update_person(person_to_update: Person):
    if validate_person_data(person_to_update):
        return db.update_db_person(person_to_update)
    else:
        return HTTPException(
            status_code=400,
            detail="Invalid data. Ensure all required fields are provided."
        )

@app.delete("/delete_people")
def delete_people():
    return db.delete_data_from_db()


if __name__ == "__main__":
    db.init_database()
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
