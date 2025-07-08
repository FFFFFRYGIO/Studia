import networkx as nx
import numpy as np


def get_analysis(graph):
    print("Analyzing graph...")

    if not nx.is_connected(graph):
        largest_cc_nodes = max(nx.connected_components(graph), key=len)
        graph = graph.subgraph(largest_cc_nodes).copy()

    n = graph.number_of_nodes()

    degrees = [d for _, d in graph.degree()]
    avg_degree = np.mean(degrees)

    # Ścieżki
    avg_shortest_path = nx.average_shortest_path_length(graph)
    norm_avg_shortest_path = avg_shortest_path / np.log(n)

    # Centralności
    betweenness = nx.betweenness_centrality(graph, normalized=True)
    closeness = nx.closeness_centrality(graph)
    eigenvector = nx.eigenvector_centrality(graph, max_iter=1000, tol=1e-6)

    # Inne
    clustering_coeff = nx.average_clustering(graph)
    density = nx.density(graph)
    largest_cc_size = n  # już po ekstrakcji największej spójnej składowej
    percent_cc_size = largest_cc_size / n  # = 1.0, bo już mamy largest CC, ale dla pełni spójności

    return {
        "Avg Degree": avg_degree,
        "Avg Shortest Path": avg_shortest_path,
        "Normalized Avg Shortest Path": norm_avg_shortest_path,
        "Clustering Coefficient": clustering_coeff,
        "Avg Betweenness (normalized)": np.mean(list(betweenness.values())),
        "Avg Closeness": np.mean(list(closeness.values())),
        "Avg Eigenvector": np.mean(list(eigenvector.values())),
        "Largest CC Size": largest_cc_size,
        "Largest CC % of all nodes": percent_cc_size,
        "Density": density,
    }
