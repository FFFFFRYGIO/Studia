from road_analyzer.get_graph import get_graph

if __name__ == '__main__':
    G = get_graph()

    # Wypisz jeden węzeł
    first_node = list(G.nodes(data=True))[0]
    print("Przykładowy węzeł:")
    print("ID:", first_node[0])
    print("Atrybuty:", first_node[1])

    # Wypisz jedną krawędź
    first_edge = list(G.edges(data=True))[0]
    print("\nPrzykładowa krawędź:")
    print("Z węzła:", first_edge[0])
    print("Do węzła:", first_edge[1])
    print("Atrybuty:", first_edge[2])
