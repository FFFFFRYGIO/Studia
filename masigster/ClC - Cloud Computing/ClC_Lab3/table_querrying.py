import os
import psycopg2


def connect_to_postgres(host, port, database, user, password):

    try:
        connection = psycopg2.connect(
            host=host,
            port=port,
            database=database,
            user=user,
            password=password
        )
        print("Connected")
        return connection
    except Exception as e:
        print("Error connecting")
        print(e)
        return None


def create_table_query():
    return """CREATE TABLE IF NOT EXISTS person (
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);"""

def pupulate_table_query():
    return """INSERT INTO person (first_name, last_name, age, email) 
VALUES 
    ('John', 'Doe', 30, 'john.doe@example.com'),
    ('Jane', 'Smith', 25, 'jane.smith@example.com'),
    ('Michael', 'Johnson', 40, 'michael.johnson@example.com'),
    ('Emily', 'Davis', 22, 'emily.davis@example.com'),
    ('William', 'Brown', 35, 'william.brown@example.com')
ON CONFLICT DO NOTHING;"""

def get_data_from_table_query():
    return """SELECT * FROM person;"""


def main():
    host = os.getenv("POSTGRES_CONNECTION_HOST", "localhost")
    port = int(os.getenv("POSTGRES_PORT", 5432))
    database = os.getenv("POSTGRES_DB", "postgres")
    user = os.getenv("POSTGRES_USER", "postgres")
    password = os.getenv("POSTGRES_PASSWORD")

    conn = connect_to_postgres(host, port, database, user, password)

    if conn:
        try:
            cursor = conn.cursor()

            cursor.execute("SELECT version();")
            version = cursor.fetchone()
            print(f"{version[0]}")

            cursor.execute(create_table_query())
            conn.commit()

            cursor.execute(pupulate_table_query())
            conn.commit()

            cursor.execute(get_data_from_table_query())
            rows = cursor.fetchall()
            print("Person data:")
            for row in rows:
                print(row)

        finally:
            conn.close()


if __name__ == "__main__":
    main()
