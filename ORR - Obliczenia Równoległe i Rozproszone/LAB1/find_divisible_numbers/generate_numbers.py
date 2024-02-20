import random


def main():
    n = 1000000

    min_number = 1
    max_number = 1000

    file_name = "numbers.txt"

    with open(file_name, "w") as file:
        for _ in range(n):
            random_number = random.randint(min_number, max_number)
            file.write(str(random_number) + "\n")

    print(f"Saved {n} numbers in '{file_name}'.")


if __name__ == '__main__':
    main()
