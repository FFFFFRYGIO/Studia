from pgmpy.factors.discrete import TabularCPD
from pgmpy.models import BayesianNetwork


def create_bayesian_network():
    # Definicja modelu
    model = BayesianNetwork([
        ('G', 'M'),
        ('M', 'C'),
        ('I', 'C'),
        ('R', 'C'),
        ('C', 'D')
    ])

    # Tworzenie CPDs

    # Global Events (G)
    cpd_G = TabularCPD(
        variable='G',
        variable_card=3,
        values=[[0.1], [0.6], [0.3]],
        state_names={'G': ['good', 'neutral', 'bad']}
    )

    # Market Condition (M) zależne od G
    cpd_M_given_G = TabularCPD(
        variable='M',
        variable_card=2,
        values=[
            [0.8, 0.5, 0.8],  # P(M=positive|G)
            [0.2, 0.5, 0.2]  # P(M=negative|G)
        ],
        evidence=['G'],
        evidence_card=[3],
        state_names={
            'M': ['positive', 'negative'],
            'G': ['good', 'neutral', 'bad']
        }
    )

    # Company Income (I)
    cpd_I = TabularCPD(
        variable='I',
        variable_card=2,
        values=[[0.25], [0.75]],
        state_names={'I': ['grow', 'not_grow']}
    )

    # Company Reputation (R)
    cpd_R = TabularCPD(
        variable='R',
        variable_card=2,
        values=[[0.6], [0.4]],
        state_names={'R': ['positive', 'negative']}
    )

    # Action Cost Change (C) zależne od M, I i R
    cpd_C = TabularCPD(
        variable='C',
        variable_card=2,
        values=[
            [0.9, 0.6, 0.5, 0.2, 0.7, 0.4, 0.3, 0.0],  # P(C=raise|...)
            [0.1, 0.4, 0.5, 0.8, 0.3, 0.6, 0.7, 1.0]  # P(C=not_raise|...)
        ],
        evidence=['M', 'I', 'R'],
        evidence_card=[2, 2, 2],
        state_names={
            'C': ['raise', 'not_raise'],
            'M': ['positive', 'negative'],
            'I': ['grow', 'not_grow'],
            'R': ['positive', 'negative']
        }
    )

    # Investment Decision (D) zależne od C
    cpd_D = TabularCPD(
        variable='D',
        variable_card=2,
        values=[
            [0.6, 0.7],  # P(D=yes|C)
            [0.4, 0.3]  # P(D=no|C)
        ],
        evidence=['C'],
        evidence_card=[2],
        state_names={
            'D': ['yes', 'no'],
            'C': ['raise', 'not_raise']
        }
    )

    # Dodanie CPDs do modelu
    model.add_cpds(cpd_G, cpd_M_given_G, cpd_I, cpd_R, cpd_C, cpd_D)

    # Sprawdzenie poprawności modelu
    if model.check_model():
        print("The Bayesian Network is correctly defined.")
    else:
        print("There is an error in the Bayesian Network definition.")

    return model


def display_model(model):
    print("\nCPDs in the model:")
    for cpd in model.cpds:
        print(cpd)


if __name__ == '__main__':
    bayesian_network = create_bayesian_network()
    display_model(bayesian_network)
