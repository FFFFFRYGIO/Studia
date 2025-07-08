import os

import networkx as nx
import pandas as pd
from matplotlib import pyplot as plt

from get_graph import load_data
from road_analyzer.find_big_roads_node import get_all_graphs_variants
from road_analyzer.graph_analyzer import analyze_graph


def display_graph(subgraph):
    plt.figure(figsize=(12, 10))
    nx.draw(subgraph, with_labels=False, node_size=10)
    plt.show()


def get_graphs_list() -> list:
    print("Gathering graphs")

    files_list = os.listdir('data')
    files_list = ['BarcelonaMap.osm'] # ['WATmap.osm']

    base_graphs = [load_data(fr'data\{file_name}') for file_name in files_list]

    all_graphs = []
    for base_graph in base_graphs:
        all_graphs.extend(get_all_graphs_variants(base_graph))

    return all_graphs

def main():

    grahps = get_graphs_list()

    print(grahps)

    results = [
        analyze_graph(graph)
        for graph in grahps
    ]

    df_results = pd.DataFrame(results)

    print(df_results.to_string())

    # graph = load_data()
    # print(graph)
    #
    # # Konwersja: MultiDiGraph → Graph
    # undirected = nx.Graph(graph)  # to usuwa wielokrotne krawędzie
    #
    # # Wyciągamy największą spójną składową (opcjonalnie, dla poprawności metryk)
    # largest_cc = max(nx.connected_components(undirected), key=len)
    # subgraph = undirected.subgraph(largest_cc).copy()
    # print(subgraph)
    #
    # display_graph(subgraph)
    #
    # analysis = get_analysis(subgraph)
    # print(analysis)


if __name__ == '__main__':
    main()

# ToDo:
#   - wizualizacja grafu na mapie osm
#   - klasteryzacja - czy jesteśmy w stanie wyróżnić jakieś obszary
#   - symulacje - manipulując wezłami sprawdzimy odporność na awarie pojedynczych dróg
#       - sprawdzimy zależność między długością drogi a jej istotnością
#   - identyfikacja głównych dróg
#   - topologie sieci drogowej
#   - porównanie sieci na WAT-cie z siecią w Warszawie
