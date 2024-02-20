import random

file = "rental_costs.txt"

with open(file, "w") as plik:
    for file in range(ilosc_liczb):
        losowa_liczba = random.randint(min_liczba, max_liczba)
        plik.write(str(losowa_liczba) + "\n")

print(f"Saved to file '{file}'.")
