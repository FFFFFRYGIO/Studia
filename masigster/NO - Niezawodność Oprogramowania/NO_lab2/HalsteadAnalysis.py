""" Niezawodność Oprogramowania Lab2 Radosław Relidzyński WCY23IV1S4 """

import os
import re

import chardet
import pandas as pd


class HalsteadAnalysis:
    """Class to specify and display Halstead parameters and values"""

    def __init__(self, file_path, programs_folder=os.path.join('Zajęcia 3-4', 'PrzykładoweProgramy')):
        self.file_path = file_path
        self.programs_folder = programs_folder
        self.source_code = ""
        self.operators = set()
        self.operands = set()
        self.total_operators = []
        self.total_operands = []

        # Define operators and operand patterns
        self.operator_patterns = [
            r'>=', r'<=', r'==', r'!=',  # Two-character operators
            r'\+=', r'-=', r'\*\=', r'/=',  # Compound operators
            r'\+\+', r'--',  # Increment and decrement operators
            r'\+', r'-', r'\*', r'/', r'%', r'>', r'<', r'=',  # Single-character operators
        ]
        self.operand_pattern = r'\b[a-zA-Z_][a-zA-Z0-9_]*\b'  # Matches variables and function names

    def detect_encoding(self):
        """Method to detect file encoding and read the content"""
        with open(os.path.join(self.programs_folder, self.file_path), "rb") as f:
            raw_data = f.read()
            result = chardet.detect(raw_data)
            self.source_code = raw_data.decode(result['encoding'])

    def clean_code(self):
        """Remove unnecessary code elements from source code"""
        # Remove includes
        self.source_code = re.sub(r'#include\s*[<"].*?[>"]', '', self.source_code)
        # Remove multiline comments
        self.source_code = re.sub(r'/\*.*?\*/', '', self.source_code, flags=re.DOTALL)
        # Remove single-line comments
        self.source_code = re.sub(r'//.*', '', self.source_code)
        # Remove string literals
        self.source_code = re.sub(r'".*?"', '', self.source_code)
        self.source_code = re.sub(r"'.*?'", '', self.source_code)
        # Remove {, } and ;
        self.source_code = re.sub(r'[{};]', '', self.source_code)
        clean_keywords = [
            'while', 'if', 'else', 'for', 'return', 'int', 'char',
            'void', 'printf', 'scanf', 'define', 'typedef', 'struct'
        ]
        for clean_keyword in clean_keywords:
            self.source_code = re.sub(rf'\b{clean_keyword}\b', '', self.source_code)
        # Remove all function calls
        self.source_code = re.sub(r'\b[a-zA-Z_][a-zA-Z0-9_]*\s*\([^)]*\)', '', self.source_code)
        # Remove ())
        self.source_code = re.sub(r'\(\)', '', self.source_code)

        # Remove blank lines
        self.source_code = re.sub(r'^\s*$', '', self.source_code, flags=re.MULTILINE)

    def analyze(self):
        """Analyze source code and calculate Halstead metrics"""
        # Clean the source code
        self.clean_code()

        remaining_code = self.source_code

        # Find operators
        for pattern in self.operator_patterns:
            matches = re.findall(pattern, remaining_code)
            self.operators.update(matches)
            self.total_operators += matches
            remaining_code = re.sub(pattern, '', remaining_code)

        # Find named operands
        named_matches = re.findall(self.operand_pattern, self.source_code)
        self.operands.update(named_matches)
        self.total_operands += named_matches

        # Find numeric operands (e.g., 0, 1, 2, 10)
        numeric_pattern = r'\b\d+\b'
        numeric_matches = re.findall(numeric_pattern, self.source_code)
        self.operands.update(numeric_matches)
        self.total_operands += numeric_matches

        # Metrics calculations
        n1 = len(self.operators)
        n2 = len(self.operands)
        N1 = len(self.total_operators)
        N2 = len(self.total_operands)
        vocabulary = n1 + n2
        length = N1 + N2
        volume = length * vocabulary.bit_length()
        difficulty = (n1 / 2) * (N2 / n2) if n2 != 0 else 0
        effort = difficulty * volume
        estimated_bugs = volume / 3000

        return {
            "Vocabulary": vocabulary,
            "Length": length,
            "Volume": volume,
            "Difficulty": difficulty,
            "Effort": effort,
            "Estimated Bugs": estimated_bugs,
            "Unique Operators": n1,
            "Unique Operands": n2,
            "Total Operators": N1,
            "Total Operands": N2,
        }


if __name__ == '__main__':
    programs = ["Program 1.c", "Program 2.c", "Program 3.c"]
    # programs = ["Program 3.c"]
    results = {}
    print()

    for program in programs:
        halstead = HalsteadAnalysis(program)
        halstead.detect_encoding()
        results[os.path.basename(program)] = halstead.analyze()

        print(f'Halstead Analysis for {program}')
        # print(halstead.source_code)
        print("Unique Operators list", halstead.operators)
        print("Total Operators List", halstead.total_operators)
        print("Unique Operands list", halstead.operands)
        print("Total Operands List", halstead.total_operands)
        print()

    results_df = pd.DataFrame(results).T

    print("Halstead Analysis Results:")
    pd.set_option('display.max_columns', None)
    pd.set_option('display.width', 0)
    pd.set_option('display.colheader_justify', 'center')
    print(results_df)
