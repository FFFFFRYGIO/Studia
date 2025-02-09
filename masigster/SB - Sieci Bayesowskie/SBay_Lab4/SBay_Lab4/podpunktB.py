from itertools import product
from collections import defaultdict

from investment_decision import create_bayesian_network


def compute_marginalized_distribution(model, excluded_vars):
    """ Computes the joint probability distribution excluding specified variables. """

    cpds = {cpd.variable: cpd for cpd in model.cpds}

    variables = [cpd.variable for cpd in model.cpds if cpd.variable not in excluded_vars]
    state_cardinalities = [cpd.variable_card for cpd in model.cpds if cpd.variable not in excluded_vars]

    marginalized_distribution = defaultdict(float)

    for full_state in product(*[range(cpd.variable_card) for cpd in model.cpds]):
        full_state_dict = dict(zip([cpd.variable for cpd in model.cpds], full_state))
        prob = 1.0

        for var in cpds:
            cpd = cpds[var]
            evidence_vars = cpd.get_evidence()

            if evidence_vars:
                evidence_values = [full_state_dict[e] for e in evidence_vars]
                prob *= cpd.values[tuple([full_state_dict[var]] + evidence_values)]
            else:
                prob *= cpd.values[full_state_dict[var]]

        marginalized_state = tuple(full_state_dict[v] for v in variables)
        marginalized_distribution[marginalized_state] += prob

    return marginalized_distribution


if __name__ == '__main__':
    bayesian_network = create_bayesian_network()

    excluded_vars = {"G": "Global Events", "M": "Market Condition"}.keys()
    marginalized_dist = compute_marginalized_distribution(bayesian_network, excluded_vars)

    print("Marginalized Joint Probability Distribution (excluding Global Events and Market Condition):")
    for state, prob in marginalized_dist.items():
        print(f"State {state}: P = {prob:.6f}")
