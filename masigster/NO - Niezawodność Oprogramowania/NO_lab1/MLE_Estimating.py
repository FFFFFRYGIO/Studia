""" Niezawodność oprogramowania Lab1 Radosław Relidzyński WCY23IV1S4 19.12.2024 """

import numpy as np
import pandas as pd


def load_excel_to_list(file_path, sheet_name="Arkusz1"):
    """ Load data from Excel file into a list """
    df = pd.read_excel(file_path, sheet_name=sheet_name, header=None)
    df = df.iloc[1:, 1:]

    values_list = df.values.flatten().tolist()

    return values_list


LIST_t = load_excel_to_list("Dane_refractored.xlsx")
VALUE_n = len(LIST_t)

SUM_ti = sum(LIST_t)
SUM_i_ti = sum((i - 1) * LIST_t[i] for i, value in enumerate(LIST_t))


def phi(N):
    """ phi function - estimating fixes """
    return VALUE_n / (N * SUM_ti - SUM_i_ti)


def lambda_intensity(t, N):
    """ Calculate intensity function for given t, N and t_list """
    cumulative_sums = np.cumsum([0] + LIST_t)

    for i in range(1, len(cumulative_sums)):
        if cumulative_sums[i - 1] < t <= cumulative_sums[i]:
            return phi(N - (i - 1))

    return 0


def expected_value(N):
    """ Calculate expected value of time for specified crash number """
    return 1 / phi(N - VALUE_n)


def validate_n_equation(N, accuracy=0.01):
    """ Insert N to equation and validate difference between left and right part """

    # Left part
    left_part = sum(1 / (N - (i - 1)) for i in range(1, VALUE_n + 1))

    # Right part
    right_part = VALUE_n * SUM_ti / (N * SUM_ti - SUM_i_ti)

    diff = abs(left_part - right_part)

    return diff < accuracy


if __name__ == '__main__':

    N_increment_step_values = [1, 0.1, 0.01]
    accuracies = [round(0.1 ** n, 8) for n in range(2, 7)]

    for N_increment_step in N_increment_step_values:

        print()
        print(f'### N_increment_step = {N_increment_step} ###')

        N = VALUE_n

        for accuracy in accuracies:
            success = False
            while not success:
                N = round(N + N_increment_step, 2)

                if validate_n_equation(N, accuracy):
                    success = True

            print()
            print(f'Found for accuracy {accuracy}')
            print(f'N = {N}, phi = {phi(N)}')
