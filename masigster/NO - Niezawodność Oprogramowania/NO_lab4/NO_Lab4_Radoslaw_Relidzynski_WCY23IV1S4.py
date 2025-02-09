""" NO Lab4 Radosław Relidzyński WCY23IV1S4 """


from itertools import product

import numpy as np
import pandas as pd


KS = [300, 250, 500, 750]
alpha = [10, 12, 25, 15]
beta = [8, 5, 4, 2]
R_min, R_max = 0.95, 1.0
K_min, K_max = 0, 34850


def reliability_function(R):
    """ reliability_function """
    R1, R2, R3, R4 = R
    numerator = 0.008 * R1 * R2 * R3 * R4
    denominator = (1 - 0.4 * R3) * ((1 - 0.8 * R1) * (1 - 0.4 * R2) - (0.08 * R1 * R2)) - 0.016 * R1 * R2 * R3
    if denominator <= 0:
        return 0
    return numerator / denominator


def cost_function(R):
    """ cost_function """
    return sum(KS[i] + alpha[i] * np.exp(beta[i] * R[i]) for i in range(4))


def calculate_solution(R):
    """ calculate_solution """
    return reliability_function(R), cost_function(R)


def validate_solution(R_value, K_value):
    """ validate_solution """
    # return R_value in (R_min, R_max) and K_value in (K_min, K_max)
    return K_value <= K_max and R_value >= R_min


def generate_R_combinations(start, stop, step):
    """ generate_R_combinations """
    R_values = np.arange(start, stop, step)
    for combination in product(R_values, repeat=4):
        yield combination


def get_valid_solutions(combinations_generator):
    """ get_valid_solutions """

    valid_solutions = []

    for R in combinations_generator:
        print(f"Running for combination: {R}")
        R_value, K_value = calculate_solution(R)
        solution_valid = validate_solution(R_value, K_value)

        if solution_valid:
            print(f"Combination {R} valid, R_value: {R_value}, K_value: {K_value}")
            valid_solutions.append((R, R_value, K_value))
        else:
            print(f"Not valid combination: {R}, R_value: {R_value}, K_value: {K_value}")

    return valid_solutions


def normalize_solutions(solutions):
    """ normalize_solutions """

    R_values = np.array([sol[1] for sol in solutions])
    K_values = np.array([sol[2] for sol in solutions])

    R_min_val, R_max_val = R_values.min(), R_values.max()
    K_min_val, K_max_val = K_values.min(), K_values.max()

    normalized_solutions = []
    for (R, R_value, K_value) in solutions:
        R_norm = (R_value - R_min_val) / (R_max_val - R_min_val) if R_max_val > R_min_val else 0
        K_norm = (K_max_val - K_value) / (K_max_val - K_min_val) if K_max_val > K_min_val else 0
        d = np.sqrt(K_norm ** 2 + (R_norm - 1) ** 2)  # Euclidean distance
        normalized_solutions.append((R, R_value, K_value, R_norm, K_norm, d))

    return normalized_solutions


def prepare_normalized_solutions_dataframe(normalized_solutions):
    """ prepare_normalized_solutions_dataframe """

    df = pd.DataFrame(normalized_solutions, columns=["R", "R(R)", "K(R)", "R_norm", "K_norm", "d"])

    df[["R1", "R2", "R3", "R4"]] = pd.DataFrame(df["R"].tolist(), index=df.index)

    column_order = ["R1", "R2", "R3", "R4"] + [col for col in df.columns if col not in ["R1", "R2", "R3", "R4"]]
    df = df[column_order]

    df.drop(columns=["R"], inplace=True)

    return df


def main():
    """ Run program """

    combinations_generator = generate_R_combinations(start=0.95, stop=1.0, step=0.01)

    valid_solutions = get_valid_solutions(combinations_generator)
    valid_solutions_normalized = normalize_solutions(valid_solutions)
    valid_solutions_normalized_sorted = sorted(valid_solutions_normalized, key=lambda x: x[-1])

    solutions_dataframe = prepare_normalized_solutions_dataframe(valid_solutions_normalized_sorted)

    print("\nBest solution:")
    print(solutions_dataframe.iloc[0])

    # ======= RESULT =======
    # Best solution:
    # R1            1.000000
    # R2            1.000000
    # R3            0.990000
    # R4            1.000000
    # R(R)          0.951923
    # K(R)      34812.806770
    # R_norm        0.000000
    # K_norm        0.000000
    # d             1.000000
    # Name: 0, dtype: float64


if __name__ == '__main__':
    main()
