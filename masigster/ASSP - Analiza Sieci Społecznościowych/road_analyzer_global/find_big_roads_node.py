import networkx as nx
from networkx import MultiDiGraph, Graph

from get_graph import load_data


def get_nodes_to_delete(graph: Graph, used_metric, amount_percentage: int = 1):
    """Get list of nodes with best degree"""

    if not 0 < amount_percentage <= 100:
        raise ValueError("amount_percentage must be between 0 and 100")

    total_nodes = graph.number_of_nodes()
    amount = max(1, total_nodes * amount_percentage // 100)

    match used_metric:
        case 'degree':
            nodes_to_sort = list(graph.degree())
        case 'betweenness':
            nodes_to_sort = list(nx.betweenness_centrality(graph).items())
        case 'closeness':
            nodes_to_sort = list(nx.closeness_centrality(graph).items())
        case 'eigenvector':
            nodes_to_sort = list(nx.eigenvector_centrality(graph, max_iter=int(1e5)).items())
        case _:
            raise ValueError("Unexpected metric")

    sorted_nodes = sorted(nodes_to_sort, key=lambda x: x[1], reverse=True)
    return sorted_nodes[:amount]


def trim_graph_from_nodes(graph: Graph, nodes_with_best_degree: list) -> MultiDiGraph:
    """Trim graph from nodes with best degree"""

    node_ids_to_remove = {node_id for node_id, _ in nodes_with_best_degree}

    for node in list(graph.nodes):
        if node in node_ids_to_remove:
            graph.remove_node(node)

    return graph


def get_all_graphs_variants(graph: Graph) -> list:
    print(f"Getting graphs variants from graph {graph}")

    metrics_to_use_for_nodes_deletion = ['degree', 'betweenness', 'closeness', 'eigenvector']

    graphs_list = [graph]

    for metric in metrics_to_use_for_nodes_deletion:
        graph_cloned = graph.copy()

        print(f'trimming graph {graph} with metric {metric}')

        nodes_to_delete = get_nodes_to_delete(graph_cloned, metric)
        trimmed_graph = trim_graph_from_nodes(graph_cloned, nodes_to_delete)

        graphs_list.append(trimmed_graph.copy())

    return graphs_list


if __name__ == '__main__':
    pass

    # graph_directed = load_data()
    # graph_undirected = nx.Graph(graph_directed)
    #
    # graphs_list = [graph_undirected]
    #
    # metrics_to_use_for_nodes_deletion = ['degree', 'betweenness', 'closeness', 'eigenvector']
    #
    # for graph in graphs_list:
    #     for metric in metrics_to_use_for_nodes_deletion:
    #         graph_cloned = graph.copy()
    #         print(graph_cloned, metric)
    #         nodes_to_delete = get_nodes_to_delete(graph_cloned, metric)
    #         print(nodes_to_delete)
    #
    #         trimmed_graph = trim_graph_from_nodes(graph_cloned, nodes_to_delete)
    #         print(trimmed_graph)


# Co robimy:
# Mamy pakiet map
# Każda mapa to graf
# Z każdego grafu powstaną duplikaty
# Duplikat to taki po usunięciu z niego 1% wierzchołków (skrzyżowań) o największym stopniu
# Na takim zbiorze grafów zrealizujemy analizę







