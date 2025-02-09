import re


def split_functions(code):
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


class CyclomaticComplexityCalculator:
    def __init__(self, file_path):
        self.file_path = file_path
        self.decision_keywords = ["if", "else if", "while", "for", "case", "?"]
        self.cyclomatic_complexity = 1

    def _remove_comments(self, code):
        return re.sub(r"//.*?$|/\*.*?\.*/", "", code, flags=re.DOTALL | re.MULTILINE)

    def calculate(self):
        try:
            with open(self.file_path, "r") as file:
                code = file.read()

            code = self._remove_comments(code)

            for keyword in self.decision_keywords:
                pattern = rf"\b{re.escape(keyword)}\b"
                self.cyclomatic_complexity += len(re.findall(pattern, code))

            return self.cyclomatic_complexity
        except FileNotFoundError:
            print("Error: File not found")
            return None


if __name__ == "__main__":
    calculator1 = CyclomaticComplexityCalculator("PrzykładoweProgramy/Program1.c")
    print(calculator1.calculate())

    calculator2 = CyclomaticComplexityCalculator("PrzykładoweProgramy/Program2.c")
    print(calculator2.calculate())

    calculator3 = CyclomaticComplexityCalculator("PrzykładoweProgramy/Program3.c")
    print(calculator3.calculate())