from pgmpy.models import BayesianNetwork
from pgmpy.factors.discrete import TabularCPD

# Deklaracja modelu struktury Bayesowskiej
model = BayesianNetwork([('A', 'T')])

# Tworzenie zmiennej A
cpd_A = TabularCPD(
    variable='A',
    variable_card=2,
    values=[[0.01], [0.99]],
    state_names={'A': ['yes', 'no']}
)

# Tworzenie zmiennej T zależnej od A
cpd_T_given_A = TabularCPD(
    variable='T',
    variable_card=2,
    values=[[0.99, 0.001], [0.01, 0.999]],
    evidence=['A'],
    evidence_card=[2],
    state_names={'T': ['yes', 'no'], 'A': ['yes', 'no']}
)

# Dodanie zmiennych modelu
model.add_cpds(cpd_A, cpd_T_given_A)


def validate_model():
    # Sprawdzenie poprawności modelu
    if model.check_model():
        print("The Bayesian Network is correctly defined.")
    else:
        print("There is an error in the Bayesian Network definition.")


def display_model():
    # Wyświetlenie modelu
    print("\nCPDs in the model:")
    for cpd in model.cpds:
        print(cpd)


def calculate_posterior(p_a, p_t_given_a):
    """Calculate posterior probability P(A=yes|T=yes)."""
    p_t = (p_t_given_a[0] * p_a) + (p_t_given_a[1] * (1 - p_a))
    p_a_given_t = (p_t_given_a[0] * p_a) / p_t
    return p_a_given_t


def podpunkt1():
    p_a = 0.2  # P(A=yes)
    p_t_given_a = [0.99, 0.001]  # P(T=yes|A=yes) i P(T=yes|A=no)

    # Obliczenia
    p_a_given_t = calculate_posterior(p_a, p_t_given_a)  # P(A=yes|T=yes)

    # Wynik
    print(f"Podpunkt1: P(A=yes|T=yes): {p_a_given_t:.4f}")


def podpunkt2():
    # Dane
    p_a = 0.001  # P(A=yes)
    p_t_given_a = [0.99, 0.001]  # P(T=yes|A=yes) i P(T=yes|A=no)

    # Obliczenia
    p_a_given_t = calculate_posterior(p_a, p_t_given_a)  # P(A=yes|T=yes)

    # Wynik
    print(f"Podpunkt2: P(A=yes|T=yes): {p_a_given_t:.4f}")


if __name__ == '__main__':
    validate_model()
    display_model()
    podpunkt1()
    podpunkt2()
