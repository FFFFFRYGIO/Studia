import sqlite3

from person import Person


def run_query(query, params=None):
    conn = sqlite3.connect("database.db")
    cursor = conn.cursor()

    if params:
        cursor.execute(query, params)
    else:
        cursor.execute(query)

    conn.commit()
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result


def init_database():
    create_query = """
    CREATE TABLE IF NOT EXISTS people (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        first_name VARCHAR(50),
        last_name VARCHAR(50),
        age INT,
        email VARCHAR(50)
    )
    """
    run_query(create_query)
    return "Database initialized"


def add_data_to_db(person: Person):
    query = "INSERT INTO people (first_name, last_name, age, email) VALUES (?, ?, ?, ?)"
    person_data = (person.first_name, person.last_name, person.age, person.email)
    run_query(query, person_data)
    return "Person added successfully"


def get_data_from_db():
    result = run_query("SELECT * FROM people")
    return result


def delete_data_from_db():
    run_query("DELETE FROM people")
    return "People successfully deleted"


def update_db_person(person_to_update: Person):
    query_str = f"UPDATE people SET %s WHERE %s"
    update_str = f" age = ?, email = ? "
    person_to_update_str = f" first_name = ? AND last_name = ? "
    query = query_str % (update_str, person_to_update_str)
    person_data = (person_to_update.first_name, person_to_update.last_name, person_to_update.age, person_to_update.email)
    run_query(query, person_data)
    return f"Person {person_to_update.first_name} {person_to_update.last_name} updated successfully"
