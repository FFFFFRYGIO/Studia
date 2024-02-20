from fastapi import FastAPI
import random

app = FastAPI()
DATA = list()


@app.get("/get_first_names")
def get_data1():
    result = DATA
    return [row['first_name'] for row in result]


@app.get("/get_emails")
def get_data2():
    result = DATA
    return [row['email'] for row in result]


@app.get("/get_all")
def get_data3():
    result = DATA
    return result


@app.post("/add_person/")
def add_person(first_name: str, last_name: str, age: int, email: str):
    person = {
        'first_name': first_name,
        'last_name': last_name,
        'age': age,
        'email': email,
    }
    DATA.append(person)
    return "Successfully added a person"


@app.post("/add_random_person")
def add_random_person():
    first_names = ["A", "B", "C"]
    last_names = ["AA", "BB", "CC"]

    first_name = random.choice(first_names)
    last_name = random.choice(last_names)
    age = random.randint(18, 60)
    email = f"{first_name}.{last_name}@gmail.com"

    person = {
        'first_name': first_name,
        'last_name': last_name,
        'age': age,
        'email': email,
    }
    DATA.append(person)
    return "Successfully added a random person"


@app.delete("/delete_people")
def delete_people():
    DATA.clear()
    return "Successfully deleted people"


# if __name__ == "__main__":
#     DATA.clear()
#     import uvicorn
#
#     uvicorn.run(app, host="0.0.0.0")
