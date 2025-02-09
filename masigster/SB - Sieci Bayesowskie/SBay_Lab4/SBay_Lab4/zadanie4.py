import pandas as pd
from pgmpy.estimators import HillClimbSearch, BicScore, MaximumLikelihoodEstimator
from pgmpy.models import BayesianNetwork
from pgmpy.utils import get_example_model


def learn_bayesian_network_from_data(file_path):
    # Wczytanie danych z pliku CSV
    data = pd.read_csv(file_path)

    # Wyświetlenie podstawowych informacji o danych
    print("Sample of the data:")
    print(data.head())
    print("\nSummary of missing values:")
    print(data.isnull().sum())

    # Usuwanie rekordów z brakującymi wartościami (opcjonalne)
    data = data.dropna()
    print(f"\nData after handling missing values (remaining rows: {len(data)}):")
    print(data.head())

    # Uczenie struktury sieci
    hc = HillClimbSearch(data)
    best_model = hc.estimate(scoring_method=BicScore(data))
    print("\nLearned structure:")
    print(best_model.edges())

    # Uczenie parametrów sieci
    model = BayesianNetwork(best_model.edges())
    model.fit(data, estimator=MaximumLikelihoodEstimator)

    print("\nLearned CPDs:")
    for cpd in model.cpds:
        print(cpd)

    return model


def main():
    # Ścieżka do pliku z danymi syntetycznymi
    file_path = 'synthetic_data.csv'

    # Uczenie modelu
    learned_model = learn_bayesian_network_from_data(file_path)

    # Zapisywanie wyników do pliku
    print("\nSaving learned model structure as 'learned_model.txt'")
    with open('learned_model.txt', 'w') as file:
        for edge in learned_model.edges():
            file.write(f"{edge[0]} -> {edge[1]}\n")

    print("\nModel structure saved!")


if __name__ == '__main__':
    main()
