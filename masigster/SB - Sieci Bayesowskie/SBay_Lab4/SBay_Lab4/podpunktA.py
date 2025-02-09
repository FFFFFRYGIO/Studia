from itertools import product

from investment_decision import create_bayesian_network


def compute_joint_distribution(model):
    """ Computes the joint probability distribution for the Bayesian Network. """

    cpds = {cpd.variable: cpd for cpd in model.cpds}

    variables = [cpd.variable for cpd in model.cpds]
    state_cardinalities = [cpd.variable_card for cpd in model.cpds]
    all_states = list(product(*[range(card) for card in state_cardinalities]))

    joint_distribution = []
    for state in all_states:
        prob = 1.0
        state_dict = dict(zip(variables, state))

        for var in variables:
            cpd = cpds[var]
            evidence_vars = cpd.get_evidence()

            if evidence_vars:
                evidence_values = [state_dict[e] for e in evidence_vars]
                prob *= cpd.values[tuple([state_dict[var]] + evidence_values)]
            else:
                prob *= cpd.values[state_dict[var]]

        joint_distribution.append((state, prob))

    return joint_distribution


if __name__ == '__main__':
    bayesian_network = create_bayesian_network()

    joint_dist = compute_joint_distribution(bayesian_network)

    print("Joint Probability Distribution:")
    for state, prob in joint_dist:
        print(f"State {state}: P = {prob:.6f}")
