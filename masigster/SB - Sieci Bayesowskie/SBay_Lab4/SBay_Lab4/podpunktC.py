from pgmpy.inference import VariableElimination

from investment_decision import create_bayesian_network


def calculate_marginal_posterior(model, evidence):

    inference = VariableElimination(model)

    all_variables = set(model.nodes())

    evidence_variables = set(evidence.keys())

    query_variables = all_variables - evidence_variables

    marginal_posteriors = {}

    for variable in query_variables:
        marginal_posteriors[variable] = inference.query(
            variables=[variable], evidence=evidence, show_progress=False
        )

    return marginal_posteriors


if __name__ == '__main__':
    bayesian_network = create_bayesian_network()

    evidence = {'G': 'good', 'R': 'positive'}

    marginal_posteriors = calculate_marginal_posterior(bayesian_network, evidence)

    print("\nMarginal posterior distributions:")
    for variable, distribution in marginal_posteriors.items():
        print(f"{variable}:\n{distribution}")
