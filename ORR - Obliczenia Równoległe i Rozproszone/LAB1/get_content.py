import pandas as pd
import random


def read_csv(path):
    df = pd.read_csv(path, on_bad_lines='skip', sep=';')
    return df


def generate_operations(number_of_transactions, neighborhoods):
    data = []

    for i in range(number_of_transactions):
        data.append([neighborhoods[random.randint(0, 3)], random.randint(20, 300)])

    return data


def generate_operation(number_of_transactions):
    data = []

    for i in range(number_of_transactions):
        data.append(random.randint(20, 300))

    return data
