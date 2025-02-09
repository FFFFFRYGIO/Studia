from pgmpy.inference import VariableElimination
from investment_decision import create_bayesian_network


def get_joint_posterior_with_target_vars(bayesian_network, observed_evidence, target_variables=None):

    inference = VariableElimination(bayesian_network)

    all_vars = set(bayesian_network.nodes())
    observed_vars = set(observed_evidence.keys())

    target_vars = target_variables if target_variables else (all_vars - observed_vars)

    joint_distribution = inference.query(variables=list(target_vars), evidence=observed_evidence, show_progress=False)

    return joint_distribution


if __name__ == '__main__':
    bayesian_network = create_bayesian_network()

    evidence = {'G': 'good', 'R': 'positive'}

    target_variables = ['M', 'C']

    marginal_posteriors = get_joint_posterior_with_target_vars(bayesian_network, evidence, target_variables)

    print("\nJoint posterior distributions for selected variables:")
    print(f"{marginal_posteriors}")
