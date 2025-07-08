import networkx as nx
import numpy as np
import matplotlib
matplotlib.use("TkAgg")

from matplotlib import pyplot as plt
import osmnx as ox

from get_graph import load_data


def display_graph(graph):
    print("Obliczanie stopnia wierzchołków...")
    degrees = dict(graph.degree())
    gdf_nodes, gdf_edges = ox.graph_to_gdfs(graph)

    gdf_nodes["degree"] = gdf_nodes.index.map(degrees)

    print("Rysowanie... (rozmiar = stopień)")
    fig, ax = plt.subplots(figsize=(12, 12))
    gdf_edges.plot(ax=ax, linewidth=1, color="gray")

    marker_sizes = gdf_nodes["degree"] * 5

    gdf_nodes.plot(
        ax=ax,
        markersize=marker_sizes,
        color="red",
        alpha=0.7,
        edgecolor="black"
    )

    plt.title("Wielkość węzła wg liczby połączeń (stopnia)")
    plt.axis("off")
    plt.show()

def main():
    graph = load_data("C:/Users/mkawk/PycharmProjects/WatMapAnaliza/road_analyzer/data/WolaMap.osm")
    print(graph)

    undirected = graph.to_undirected()
    largest_cc_nodes = max(nx.connected_components(undirected), key=len)

    subgraph = graph.subgraph(largest_cc_nodes).copy()

    display_graph(subgraph)


if __name__ == '__main__':
    main()

