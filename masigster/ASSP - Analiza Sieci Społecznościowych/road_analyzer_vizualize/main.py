import networkx as nx
import numpy as np
from matplotlib import pyplot as plt

from get_graph import load_data
from road_analyzer.get_analysis import get_analysis

def display_graph(subgraph):
    plt.figure(figsize=(12, 10))
    nx.draw(subgraph, with_labels=False, node_size=10)
    plt.show()

def main():
    graph = load_data()
    print(graph)

    # Konwersja: MultiDiGraph → Graph
    undirected = nx.Graph(graph)  # to usuwa wielokrotne krawędzie

    # Wyciągamy największą spójną składową (opcjonalnie, dla poprawności metryk)
    largest_cc = max(nx.connected_components(undirected), key=len)
    subgraph = undirected.subgraph(largest_cc).copy()
    print(subgraph)

    display_graph(subgraph)

    analysis = get_analysis(subgraph)
    print(analysis)


if __name__ == '__main__':
    main()