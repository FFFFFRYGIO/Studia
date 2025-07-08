import os
import osmnx as ox


def load_data(osm_path: str = "C:/Users/mkawk/PycharmProjects/WatMapAnaliza/road_analyzer/data/WATmap.osm"):

    print("Loading graph from pbf file ...")

    G = ox.graph_from_xml(osm_path, simplify=True)
    output_path = "output/mazowieckie.graphml"
    os.makedirs("output", exist_ok=True)
    ox.save_graphml(G, filepath=output_path)

    return G

def get_graph():

    print("Loading graph from graphml file ...")

    file_path = "C:/Users/mkawk/PycharmProjects/AnalizaBitCoin/road_analyzer/output/mazowieckie.graphml"

    graph = ox.load_graphml(filepath=file_path)

    return graph


if __name__ == "__main__":
    print(load_data())


