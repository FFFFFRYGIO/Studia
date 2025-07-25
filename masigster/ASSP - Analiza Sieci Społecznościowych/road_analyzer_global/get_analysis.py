import networkx as nx
import numpy as np


def get_analysis(graph):
    print("Analyzing graph...")

    degrees = [d for _, d in graph.degree()]
    avg_degree = np.mean(degrees)
    avg_shortest_path = nx.average_shortest_path_length(graph) if nx.is_connected(graph) else None
    clustering_coeff = nx.average_clustering(graph)
    betweenness = nx.betweenness_centrality(graph)
    closeness = nx.closeness_centrality(graph)
    eigenvector = nx.eigenvector_centrality(graph, max_iter=1000, tol=1e-6)

    largest_cc = max(nx.connected_components(graph), key=len) if nx.is_connected(graph) else None
    largest_cc_size = len(largest_cc) if largest_cc else None
    density = nx.density(graph)

    return {
        "Avg Degree": avg_degree,
        "Avg Shortest Path": avg_shortest_path,
        "Clustering Coefficient": clustering_coeff,
        "Avg Betweenness": np.mean(list(betweenness.values())),
        "Avg Closeness": np.mean(list(closeness.values())),
        "Avg Eigenvector": np.mean(list(eigenvector.values())),
        "Largest CC Size": largest_cc_size,
        "Density": density
    }


# Analizy:
# Czysty graf
# Po usunięciu nodeów o najlepszym Degree
# Po usunięciu nodeów o najlepszym Betweenness
# Po usunięciu nodeów o najlepszym Closeness
# Po usunięciu nodeów o najlepszym Eigenvector



