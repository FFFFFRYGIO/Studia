import os

import osmnx as ox
# from pyrosm import OSM
import networkx as nx

def load_data(osm_path: str = "data/WATmap.osm"):

    print(f"Loading graph from pbf file {osm_path}")

    # print("Loading OSM XML file...")
    G = ox.graph_from_xml(osm_path, simplify=True)
    # print("Graph loaded.")
    # print(nx.info(G))

    # Zapisz do .graphml
    output_path = "output/mazowieckie.graphml"
    os.makedirs("output", exist_ok=True)
    # print(f"Saving graph to {output_path} ...")
    ox.save_graphml(G, filepath=output_path)
    # print("Graph saved successfully.")

    G = nx.Graph(G)

    return G

    # pbf_path = "C:/Users/mkawk/PycharmProjects/AnalizaBitCoin/road_analyzer/data/andorra-latest.osm.pbf"
    # # pbf_path = "C:/Users/mkawk/PycharmProjects/AnalizaBitCoin/road_analyzer/data/map (2).osm"
    # osm = OSM(pbf_path)
    # print("Loading data...")
    # print(osm)
    # nodes, edges = osm.get_network(nodes=True, network_type='driving')
    # print("Data loaded.")
    #
    # graph = osm.to_graph(nodes, edges, graph_type='networkx', retain_all=True)
    # print("Graph created.")
    #
    # # === Zapis grafu do pliku ===
    # output_path = "output/mazowieckie.graphml"
    # print(f"Saving graph to {output_path} ...")
    # ox.save_graphml(graph, filepath=output_path)
    # print("Graph saved successfully.")
    #
    # return graph

def get_graph():

    print("Loading graph from graphml file ...")

    file_path = "C:/Users/mkawk/PycharmProjects/AnalizaBitCoin/road_analyzer/output/mazowieckie.graphml"  # <-- ścieżka do zapisanego grafu

    # print(f"Reading graph from {file_path} ...")
    graph = ox.load_graphml(filepath=file_path)

    # print("Graph loaded.")
    # print(nx.info(graph))

    return graph


if __name__ == "__main__":
    print(load_data())


