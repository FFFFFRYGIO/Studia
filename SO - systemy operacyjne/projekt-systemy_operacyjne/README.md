# Projekt semestralny z przedmiotu

W ramach projektu należało zrobić program typu producent-konsument

Aby uruchomić program, należy wywołać skrypt "app.sh"

# Wytyczne:

Aplikacji zadaniem jest przechwytywanie znaków
wczytanych od urzytkownika oraz wpisanie ich do
pliku "converted.txt".

Działanie aplikacji:
- proces1:
pobranie znaku, przekazanie go do procesu2
poprzez mechanizm PIPE
- proces2:
konwersja znaku, przekazanie go do procesu3
poporzez mechanizm pamięci współdzielonej
- proces3:
wpisanie znaku do pliku "converted.txt"

Aplikacja jest zapętlona i działa do momentu
wysłania sygnału zakończenia programu.

Może ona również zostać wstrzymana, a następnie
wznowiona poprzez odpowiednie sygnały. Poprzez
wstrzymanie rozumiane jest wstrzymanie
synchronicznej wymiany danych między procesami.

Po zakończeniu działania aplikacji uruchamiany
jest proces konwertujący z powrotem wczytane znaki
w celu sprawdzenia poprawności działania programu