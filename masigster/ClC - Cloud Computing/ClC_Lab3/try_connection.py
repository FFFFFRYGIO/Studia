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

        finally:
            conn.close()


if __name__ == "__main__":
    main()
