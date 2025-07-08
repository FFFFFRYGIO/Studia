import networkx as nx

# Main config
num_nodes = 100
num_edges = 2  # Edges for each new node
rewiring_prob = 0.1  # Probability of rewiring

# 1) Erdos-Renyi
prob_edge = 0.05  # Connection probability
erg_graph = nx.erdos_renyi_graph(num_nodes, prob_edge)

# 2) Barabasi-Albert
ba_graph = nx.barabasi_albert_graph(num_nodes, num_edges)

# 3) Watts-Strogatz
ws_graph = nx.watts_strogatz_graph(num_nodes, num_edges * 2, rewiring_prob)

# 4) Stochastic Block Model (SBM)
sizes = [30, 30, 40]  # Sizes of individual communities
p_intra = 0.6  # High probability of connections within communities
p_inter = 0.05  # Low probability of connections between communities
p_matrix = [[p_intra if i == j else p_inter for j in range(len(sizes))]
            for i in range(len(sizes))]
sbm_graph = nx.stochastic_block_model(sizes, p_matrix)

# 6) Planted Partition
num_communities = 4  # Number of communities
community_size = 25  # Size of each community
p_in = 0.5  # High probability of connection within communities
p_out = 0.05  # Low probability of connection between communities
planted_graph = nx.planted_partition_graph(num_communities, community_size, p_in, p_out)

# 7) Karate Club
karate_graph = nx.karate_club_graph()

# 8) Random Geometric
radius = 0.3  # Radius within which connection occurs
rg_graph = nx.random_geometric_graph(num_nodes, radius)

# 9) Powerlaw Cluster
powerlaw_graph = nx.powerlaw_cluster_graph(num_nodes, num_edges, 0.1)

graphs_dict = {
    "Erdos-Renyi": erg_graph,
    "Barabasi-Albert": ba_graph,
    "Watts-Strogatz": ws_graph,
    "Stochastic Block Model (SBM)": sbm_graph,
    "Planted Partition": planted_graph,
    "Karate Club": karate_graph,
    "Random Geometric": rg_graph,
    "Powerlaw Cluster": powerlaw_graph
}
