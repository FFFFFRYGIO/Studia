import matplotlib
import matplotlib.pyplot as plt
import networkx as nx
import pandas as pd

from graph_analyzer import analyze_graph
from graphs import graphs_dict

matplotlib.use('TkAgg')

if __name__ == '__main__':

    # Gather analysis
    results = [
        analyze_graph(graph, name=graph_name)
        for graph_name, graph in graphs_dict.items()
    ]

    print()

    # Create analysis dataframe
    df_results = pd.DataFrame(results)
    print(df_results.to_string())

    # Plot graphs
    graphs_per_row = round(len(graphs_dict) / 2)
    fig, axes = plt.subplots(2, graphs_per_row, figsize=(3 * graphs_per_row, 6))
    axes_flat = axes.flatten()

    for ax, (title, graph) in zip(axes_flat, graphs_dict.items()):
        nx.draw_spring(graph, ax=ax, node_size=20, edge_color="gray", alpha=0.7)
        ax.set_title(title)

    plt.show()
