""" Mccabe Cyclomatic """

import os
import re

import networkx as nx
import matplotlib
matplotlib.use('TkAgg')  # Use TkAgg backend (works on most systems)
import matplotlib.pyplot as plt


class MccabeCyclomatic:
    """ XXX """

    def __init__(self):
        self.examples_dir = "PrzykładoweProgramy"

        self.file_names = os.listdir(self.examples_dir)

        self.file_names = ['Program1.c']

    def get_c_code(self, file_name):
        """ Parse the C code to identify control flow constructs and function definitions. """
        with open(os.path.join(self.examples_dir, file_name)) as f:
            code = f.read()

        return code

    @staticmethod
    def trim_c_code(code):
        """ Remove printf and scanf instructions from the C code. """

        # Remove includes
        code = re.sub(r'#include\s*[<"].*?[>"]', '', code)
        # Remove multiline comments
        code = re.sub(r'/\*.*?\*/', '', code, flags=re.DOTALL)
        # Remove single-line comments
        code = re.sub(r'//.*', '', code)
        # Remove string literals
        code = re.sub(r'".*?"', '', code)
        code = re.sub(r"'.*?'", '', code)

        # Remove blank lines
        code = re.sub(r'^\s*$', '\n', code)

        print(code)

        return code

    def split_functions(self, code):
        # Wzorzec dla funkcji (zakłada, że funkcja zaczyna się od typu zwracanego, np. 'int', 'void')
        function_pattern = re.compile(r'^[a-zA-Z_][a-zA-Z0-9_]*\s+[a-zA-Z_][a-zA-Z0-9_]*\s*\(.*\)\s*{', re.MULTILINE)

        # Inicjalizowanie listy segmentów
        segments = []

        # Dzielimy kod na funkcje
        matches = list(function_pattern.finditer(code))

        if not matches:
            return segments

        # Dodajemy pierwszy segment (od początku do pierwszej funkcji)
        start = 0
        for match in matches:
            end = match.start()
            segments.append(code[start:end].strip())  # dodajemy kod przed funkcją
            start = match.start()

        # Dodajemy ostatnią funkcję
        segments.append(code[start:].strip())

        return segments

    def build_control_flow_graph(self, code: str):
        """ Build a control flow graph based on the number of control constructs. """

        graph = nx.DiGraph()
        graph.add_node('main')
        # self.visualize_flow_graph(graph)

        graph_num = 0

        control_patterns = [
            r'\bif\b',
            r'\belse if\b',
            r'\bfor\b',
            r'\bwhile\b',
            r'\bdo\b',
            r'\bswitch\b',
            r'\bcase\b',
        ]

        pulled_code = ''

        searched_patterns = []
        brackets_monitor = []

        switch_case_counting = False
        switch_case_count = 0

        for char in code:

            # get another code character
            pulled_code += char

            # Check for any control structure patterns
            for pattern in control_patterns:
                if re.search(pattern, pulled_code):

                    # Add pattern to searched_patterns
                    searched_patterns += [{'p': pattern.strip('\\b'), 'closed': False}]

                    # Once a control statement is found, reset pulled_code to capture the next statement
                    pulled_code = ''
                    break

            # When no search patterns, skip
            if not searched_patterns:
                break

            last_pattern = searched_patterns[-1]

            # # # Specify if we are closing last pattern

            # Opening brackets
            if char in '({[':
                brackets_monitor.append(char)
                break

            close_last_pattern = False

            if brackets_monitor:  # There are opened brackets
                last_bracket = brackets_monitor[-1]
                if last_bracket == '[':
                    if char == ']':
                        brackets_monitor.pop()
                elif last_bracket == '(':
                    if char == ')':
                        brackets_monitor.pop()
                elif last_bracket == '{':
                    if char == '}':
                        close_last_pattern = True

            else:  # No opened brackets
                if char == ';':
                    close_last_pattern = True

            # # # Close the pattern if it has found close state

            if close_last_pattern:

                if searched_patterns[-1]['closed'] == True:
                    # # # Finalize the pattern
                    pass

                    if switch_case_counting:
                        if searched_patterns[-1] == 'case':
                            switch_case_count += 1
                        else:  # End of count
                            graph_num += switch_case_count - 1
                            switch_case_counting = False
                            switch_case_count = 0

                    elif searched_patterns[-1] == 'switch':
                        switch_case_counting = True
                        switch_case_count = 0

                    elif searched_patterns[-1] == 'if':
                        graph.add_node('if')
                        graph_num += 1

                    elif searched_patterns[-1] == 'else':
                        graph_num += 0

                    elif searched_patterns[-1] in ('for', 'do', 'while'):
                        graph_num += 1

                    else:
                        raise ValueError(f"Unrecognized pattern: {searched_patterns[-1]}")

                else:
                    searched_patterns[-1]['closed'] = True

        print(searched_patterns)

        return graph

    @staticmethod
    def visualize_flow_graph(graph):
        """ Visualize the control flow graph using matplotlib. """
        pos = nx.spring_layout(graph)
        nx.draw(graph, pos, with_labels=True, node_color='lightblue', node_size=500, font_size=10, font_weight='bold')
        plt.title("Control Flow Graph")
        plt.show()

    def process_program(self, file_name):
        """ XXX """

        code = self.get_c_code(file_name)
        trimmed_code = self.trim_c_code(code)

        splited_codes = self.split_functions(trimmed_code)

        for splitted_code in splited_codes:
            self.build_control_flow_graph(trimmed_code)

    def main(self):
        """ XXX """

        for file_name in self.file_names:
            print(f'Processing {file_name}')
            self.process_program(file_name)


if __name__ == "__main__":
    mccabe = MccabeCyclomatic()
    mccabe.main()
