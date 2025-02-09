import os
import psycopg2
from psycopg2.extras import RealDictCursor
from person import Person

POSTGRES_USER = os.getenv("POSTGRES_USER", "postgres")
POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD")
POSTGRES_DB = os.getenv("POSTGRES_DB", "postgres")
POSTGRES_CONNECTION_HOST = os.getenv("POSTGRES_CONNECTION_HOST", "localhost")
POSTGRES_PORT = int(os.getenv("POSTGRES_PORT", 5432))

def get_db_connection():
    conn = psycopg2.connect(
        dbname=POSTGRES_DB,
        user=POSTGRES_USER,
        password=POSTGRES_PASSWORD,
        host=POSTGRES_CONNECTION_HOST,
        port=POSTGRES_PORT,
        cursor_factory=RealDictCursor
    )
    return conn

def run_query(query, params=None):
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        if params:
            cursor.execute(query, params)
        else:
            cursor.execute(query)

        if query.strip().lower().startswith("select"):
            result = cursor.fetchall()
        else:
            conn.commit()
            result = None

    finally:
        cursor.close()
        conn.close()

    return result

def init_database():
    create_query = """
    CREATE TABLE IF NOT EXISTS people (
        id SERIAL PRIMARY KEY,
        first_name VARCHAR(50) NOT NULL,
        last_name VARCHAR(50) NOT NULL,
        age INT NOT NULL,
        email VARCHAR(50) UNIQUE NOT NULL
    )
    """
    run_query(create_query)
    return "Database initialized"

def add_data_to_db(person: Person):
    query = "INSERT INTO people (first_name, last_name, age, email) VALUES (%s, %s, %s, %s) ON CONFLICT DO NOTHING"
    person_data = (person.first_name, person.last_name, person.age, person.email)
    run_query(query, person_data)
    return "Person added successfully"

def get_data_from_db():
    query = "SELECT * FROM people"
    result = run_query(query)
    return result

def delete_data_from_db():
    query = "DELETE FROM people"
    run_query(query)
    return "People successfully deleted"

def update_db_person(person_to_update: Person):
    query = """
    UPDATE people 
    SET age = %s, email = %s
    WHERE first_name = %s AND last_name = %s
    """
    person_data = (person_to_update.age, person_to_update.email, person_to_update.first_name, person_to_update.last_name)
    run_query(query, person_data)
    return f"Person {person_to_update.first_name} {person_to_update.last_name} updated successfully"
