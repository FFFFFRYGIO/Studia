from collections import defaultdict

from networkx import MultiDiGraph

from get_graph import load_data


def get_biggest_roads(graph: MultiDiGraph, amount: int = 10):
    road_lengths = defaultdict(float)

    for u, v, key, data in graph.edges(keys=True, data=True):
        # print(u, v, key, data)
        osmid = data.get("osmid")
        length = data.get("length", 0)

        if osmid and isinstance(length, (int, float)):
            road_lengths[str(osmid)] = length

    sorted_roads = sorted(road_lengths.items(), key=lambda x: x[1], reverse=True)
    return sorted_roads[:amount]



def trim_graph_from_biggest_roads(graph: MultiDiGraph, biggest_roads_osmids) -> MultiDiGraph:

    for u, v, key, data in list(graph.edges(keys=True, data=True)):
        osmid = data.get("osmid")

        if isinstance(osmid, list):
            if any(oid in biggest_roads_osmids for oid in osmid):
                graph.remove_edge(u, v, key)
        elif osmid in biggest_roads_osmids:
            graph.remove_edge(u, v, key)

    return graph


if __name__ == '__main__':
    graph = load_data()
    print(graph.number_of_edges(), graph.number_of_nodes())

    biggest_roads = get_biggest_roads(graph, 20)
    biggest_roads_osmids = {int(osmid) if osmid.isdigit() else osmid for osmid, _ in biggest_roads}
    print(biggest_roads_osmids)

    trimmed = trim_graph_from_biggest_roads(graph, biggest_roads_osmids)
    print(trimmed.number_of_edges(), trimmed.number_of_nodes())
