import numpy as np
from pgmpy.sampling import BayesianModelSampling

from investment_decision import create_bayesian_network


def generate_synthetic_data(model, num_samples, missing_rate, random_seed):
    # Ustawienie ziarna losowości
    np.random.seed(random_seed)

    # Generowanie próbek
    sampler = BayesianModelSampling(model)
    data = sampler.forward_sample(size=num_samples, seed=random_seed)

    # Wprowadzanie brakujących wartości
    data = data.applymap(lambda x: x.decode('utf-8') if isinstance(x, bytes) else x)  # Konwersja bajtów do stringów
    for col in data.columns:
        # Losujemy, które wartości w tej kolumnie mają być brakujące
        missing_indices = data.sample(frac=missing_rate).index
        data.loc[missing_indices, col] = np.nan

    return data


if __name__ == '__main__':
    # Tworzenie sieci Bayesowskiej
    bayesian_network = create_bayesian_network()

    # Generowanie danych syntetycznych
    num_samples = 1000
    missing_rate = 0.02  # 2%
    random_seed = 1234

    data = generate_synthetic_data(bayesian_network, num_samples, missing_rate, random_seed)

    # Zapisywanie danych do pliku CSV
    data.to_csv('synthetic_data.csv', index=False)
    print("Synthetic data generated and saved to 'synthetic_data.csv'.")
