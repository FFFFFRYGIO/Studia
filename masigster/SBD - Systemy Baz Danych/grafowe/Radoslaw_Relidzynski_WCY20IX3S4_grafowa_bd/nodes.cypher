// Znizka

CREATE (:Znizka {RodzajZnizki: 'rodzinna', ProcentUmazany: 37}),
       (:Znizka {RodzajZnizki: 'student', ProcentUmazany: 50}),
       (:Znizka {RodzajZnizki: 'krwiodawca', ProcentUmazany: 75});

// Klient

CREATE (:Klient {NrKlienta: 1, Imie: 'Kamil', Nazwisko: 'Madajski', DataUrodzenia: date('2000-12-01'), Plec: 'M'}),
       (:Klient {NrKlienta: 2, Imie: 'Emilia', Nazwisko: 'Książkiewicz', DataUrodzenia: date('1990-02-06'), Plec: 'K'}),
       (:Klient {NrKlienta: 3, Imie: 'Mateusz', Nazwisko: 'Dybek', DataUrodzenia: date('1993-06-12'), Plec: 'M'}),
       (:Klient {NrKlienta: 4, Imie: 'Zofia', Nazwisko: 'Komosa', DataUrodzenia: date('2001-05-12'), Plec: 'K'}),
       (:Klient {NrKlienta: 5, Imie: 'Krystyna', Nazwisko: 'Czarniak', DataUrodzenia: date('1992-12-05'), Plec: 'K'}),
       (:Klient {NrKlienta: 6, Imie: 'Janusz', Nazwisko: 'Grzelczak', DataUrodzenia: date('2002-08-03'), Plec: 'M'}),
       (:Klient {NrKlienta: 7, Imie: 'Albert', Nazwisko: 'Świątkowski', DataUrodzenia: date('1995-04-06'), Plec: 'M'}),
       (:Klient {NrKlienta: 8, Imie: 'Krzysztof', Nazwisko: 'Cieluch', DataUrodzenia: date('1991-10-09'), Plec: 'M'}),
       (:Klient {NrKlienta: 9, Imie: 'Małgorzata', Nazwisko: 'Handzlik', DataUrodzenia: date('2001-08-11'), Plec: 'K'}),
       (:Klient {NrKlienta: 10, Imie: 'Tobiasz', Nazwisko: 'Ciszek', DataUrodzenia: date('1996-08-03'), Plec: 'M'});

// Lotnisko

CREATE (:Lotnisko {Nazwa: 'Londyn Heathrow', KrajPolozenia: 'Anglia'}),
       (:Lotnisko {Nazwa: 'Paryż Charles de Gaulle', KrajPolozenia: 'Francja'}),
       (:Lotnisko {Nazwa: 'Frankfurt International Airport', KrajPolozenia: 'Niemcy'}),
       (:Lotnisko {Nazwa: 'Amsterdam Airport', KrajPolozenia: 'Holandia'}),
       (:Lotnisko {Nazwa: 'Rzym Fiumicino', KrajPolozenia: 'Włochy'}),
       (:Lotnisko {Nazwa: 'Madryt', KrajPolozenia: 'Hiszpania'}),
       (:Lotnisko {Nazwa: 'Monachium', KrajPolozenia: 'Niemcy'}),
       (:Lotnisko {Nazwa: 'Barcelona Airport', KrajPolozenia: 'Hiszpania'});

// Model

CREATE (:Model {Nazwa: 'Boeing 787-8 Dreamliner'}),
       (:Model {Nazwa: 'Boeing 747-200'}),
       (:Model {Nazwa: 'DHC-6 Twin Otter'}),
       (:Model {Nazwa: 'Antonov AN-225 Mrija'}),
       (:Model {Nazwa: 'Boeing 777-300ER'}),
       (:Model {Nazwa: 'DC-4 Balair'}),
       (:Model {Nazwa: 'A380-800 British Airways'}),
       (:Model {Nazwa: 'Concorde'}),
       (:Model {Nazwa: 'Boeing 747-300'}),
       (:Model {Nazwa: 'C-54D Skymaster'});

// Pracownik

CREATE (:Pracownik {NrPracownika: 1, Imie: 'Mariusz', Nazwisko: 'Szuszkiewicz', DataUrodzenia: date('1985-07-01')}),
       (:Pracownik {NrPracownika: 2, Imie: 'Piotr', Nazwisko: 'Gała', DataUrodzenia: date('1981-01-25')}),
       (:Pracownik {NrPracownika: 3, Imie: 'Waldemar', Nazwisko: 'Świerczewski', DataUrodzenia: date('1992-11-14')}),
       (:Pracownik {NrPracownika: 4, Imie: 'Maja', Nazwisko: 'Kozik', DataUrodzenia: date('1990-11-15')}),
       (:Pracownik {NrPracownika: 5, Imie: 'Joanna', Nazwisko: 'Krupa', DataUrodzenia: date('1991-07-13')}),
       (:Pracownik {NrPracownika: 6, Imie: 'Natalia', Nazwisko: 'Kortas', DataUrodzenia: date('1983-03-05')}),
       (:Pracownik {NrPracownika: 7, Imie: 'Tomasz', Nazwisko: 'Klasa', DataUrodzenia: date('1981-06-09')}),
       (:Pracownik {NrPracownika: 8, Imie: 'Szymon', Nazwisko: 'Bucior', DataUrodzenia: date('1989-01-02')}),
       (:Pracownik {NrPracownika: 9, Imie: 'Emil', Nazwisko: 'Mieczkowski', DataUrodzenia: date('1982-07-21')}),
       (:Pracownik {NrPracownika: 10, Imie: 'Maria', Nazwisko: 'Wieczorek', DataUrodzenia: date('1990-05-22')});

// Samolot

CREATE (:Samolot {NrSamolotu: 1, RokProdukcji: 2013, Model: 'Concorde'}),
       (:Samolot {NrSamolotu: 2, RokProdukcji: 2015, Model: 'Boeing 747-200'}),
       (:Samolot {NrSamolotu: 3, RokProdukcji: 2010, Model: 'A380-800 British Airways'}),
       (:Samolot {NrSamolotu: 4, RokProdukcji: 2005, Model: 'Antonov AN-225 Mrija'}),
       (:Samolot {NrSamolotu: 5, RokProdukcji: 2008, Model: 'Boeing 777-300ER'}),
       (:Samolot {NrSamolotu: 6, RokProdukcji: 2014, Model: 'Boeing 787-8 Dreamliner'}),
       (:Samolot {NrSamolotu: 7, RokProdukcji: 2019, Model: 'A380-800 British Airways'}),
       (:Samolot {NrSamolotu: 8, RokProdukcji: 2010, Model: 'C-54D Skymaster'}),
       (:Samolot {NrSamolotu: 9, RokProdukcji: 2013, Model: 'Concorde'}),
       (:Samolot {NrSamolotu: 10, RokProdukcji: 2010, Model: 'Boeing 787-8 Dreamliner'});

// Lot

CREATE (lot1:Lot {NrLotu: 1, DataLotu: date('2025-04-16'), CzasLotuMin: 60}),
       (lot2:Lot {NrLotu: 2, DataLotu: date('2025-06-23'), CzasLotuMin: 60}),
       (lot3:Lot {NrLotu: 3, DataLotu: date('2025-01-13'), CzasLotuMin: 60}),
       (lot4:Lot {NrLotu: 4, DataLotu: date('2025-05-31'), CzasLotuMin: 60}),
       (lot5:Lot {NrLotu: 5, DataLotu: date('2025-01-01'), CzasLotuMin: 60}),
       (lot6:Lot {NrLotu: 6, DataLotu: date('2025-09-26'), CzasLotuMin: 60}),
       (lot7:Lot {NrLotu: 7, DataLotu: date('2025-09-23'), CzasLotuMin: 60}),
       (lot8:Lot {NrLotu: 8, DataLotu: date('2025-03-29'), CzasLotuMin: 60}),
       (lot9:Lot {NrLotu: 9, DataLotu: date('2025-07-23'), CzasLotuMin: 60}),
       (lot10:Lot {NrLotu: 10, DataLotu: date('2025-03-19'), CzasLotuMin: 60});

// Miejsce

CREATE (:Miejsce {NrMiejsca: 1, Klasa: 'biznes', NrSamolotu: 1}),
       (:Miejsce {NrMiejsca: 2, Klasa: 'pierwsza', NrSamolotu: 1}),
       (:Miejsce {NrMiejsca: 3, Klasa: 'pierwsza', NrSamolotu: 1}),
       (:Miejsce {NrMiejsca: 4, Klasa: 'ekonomiczna', NrSamolotu: 1}),
       (:Miejsce {NrMiejsca: 5, Klasa: 'ekonomiczna', NrSamolotu: 1}),
       (:Miejsce {NrMiejsca: 1, Klasa: 'biznes', NrSamolotu: 2}),
       (:Miejsce {NrMiejsca: 2, Klasa: 'pierwsza', NrSamolotu: 2}),
       (:Miejsce {NrMiejsca: 3, Klasa: 'pierwsza', NrSamolotu: 2}),
       (:Miejsce {NrMiejsca: 4, Klasa: 'ekonomiczna', NrSamolotu: 2}),
       (:Miejsce {NrMiejsca: 5, Klasa: 'ekonomiczna', NrSamolotu: 2}),
       (:Miejsce {NrMiejsca: 1, Klasa: 'biznes', NrSamolotu: 3}),
       (:Miejsce {NrMiejsca: 2, Klasa: 'pierwsza', NrSamolotu: 3}),
       (:Miejsce {NrMiejsca: 3, Klasa: 'pierwsza', NrSamolotu: 3}),
       (:Miejsce {NrMiejsca: 4, Klasa: 'ekonomiczna', NrSamolotu: 3}),
       (:Miejsce {NrMiejsca: 5, Klasa: 'ekonomiczna', NrSamolotu: 3}),
       (:Miejsce {NrMiejsca: 1, Klasa: 'biznes', NrSamolotu: 4}),
       (:Miejsce {NrMiejsca: 2, Klasa: 'pierwsza', NrSamolotu: 4}),
       (:Miejsce {NrMiejsca: 3, Klasa: 'pierwsza', NrSamolotu: 4}),
       (:Miejsce {NrMiejsca: 4, Klasa: 'ekonomiczna', NrSamolotu: 4}),
       (:Miejsce {NrMiejsca: 5, Klasa: 'ekonomiczna', NrSamolotu: 4}),
       (:Miejsce {NrMiejsca: 1, Klasa: 'biznes', NrSamolotu: 5}),
       (:Miejsce {NrMiejsca: 2, Klasa: 'pierwsza', NrSamolotu: 5}),
       (:Miejsce {NrMiejsca: 3, Klasa: 'pierwsza', NrSamolotu: 5}),
       (:Miejsce {NrMiejsca: 4, Klasa: 'ekonomiczna', NrSamolotu: 5}),
       (:Miejsce {NrMiejsca: 5, Klasa: 'ekonomiczna', NrSamolotu: 5}),
       (:Miejsce {NrMiejsca: 1, Klasa: 'biznes', NrSamolotu: 6}),
       (:Miejsce {NrMiejsca: 2, Klasa: 'pierwsza', NrSamolotu: 6}),
       (:Miejsce {NrMiejsca: 3, Klasa: 'pierwsza', NrSamolotu: 6}),
       (:Miejsce {NrMiejsca: 4, Klasa: 'ekonomiczna', NrSamolotu: 6}),
       (:Miejsce {NrMiejsca: 5, Klasa: 'ekonomiczna', NrSamolotu: 6}),
       (:Miejsce {NrMiejsca: 1, Klasa: 'biznes', NrSamolotu: 7}),
       (:Miejsce {NrMiejsca: 2, Klasa: 'pierwsza', NrSamolotu: 7}),
       (:Miejsce {NrMiejsca: 3, Klasa: 'pierwsza', NrSamolotu: 7}),
       (:Miejsce {NrMiejsca: 4, Klasa: 'ekonomiczna', NrSamolotu: 7}),
       (:Miejsce {NrMiejsca: 5, Klasa: 'ekonomiczna', NrSamolotu: 7}),
       (:Miejsce {NrMiejsca: 1, Klasa: 'biznes', NrSamolotu: 8}),
       (:Miejsce {NrMiejsca: 2, Klasa: 'pierwsza', NrSamolotu: 8}),
       (:Miejsce {NrMiejsca: 3, Klasa: 'pierwsza', NrSamolotu: 8}),
       (:Miejsce {NrMiejsca: 4, Klasa: 'ekonomiczna', NrSamolotu: 8}),
       (:Miejsce {NrMiejsca: 5, Klasa: 'ekonomiczna', NrSamolotu: 8}),
       (:Miejsce {NrMiejsca: 1, Klasa: 'biznes', NrSamolotu: 9}),
       (:Miejsce {NrMiejsca: 2, Klasa: 'pierwsza', NrSamolotu: 9}),
       (:Miejsce {NrMiejsca: 3, Klasa: 'pierwsza', NrSamolotu: 9}),
       (:Miejsce {NrMiejsca: 4, Klasa: 'ekonomiczna', NrSamolotu: 9}),
       (:Miejsce {NrMiejsca: 5, Klasa: 'ekonomiczna', NrSamolotu: 9}),
       (:Miejsce {NrMiejsca: 1, Klasa: 'biznes', NrSamolotu: 10}),
       (:Miejsce {NrMiejsca: 2, Klasa: 'pierwsza', NrSamolotu: 10}),
       (:Miejsce {NrMiejsca: 3, Klasa: 'pierwsza', NrSamolotu: 10}),
       (:Miejsce {NrMiejsca: 4, Klasa: 'ekonomiczna', NrSamolotu: 10}),
       (:Miejsce {NrMiejsca: 5, Klasa: 'ekonomiczna', NrSamolotu: 10});

// Bilet

CREATE (:Bilet {KodBiletu: 'NZY114', Cena: 141.78}),
       (:Bilet {KodBiletu: 'RND132', Cena: 92.16}),
       (:Bilet {KodBiletu: 'YMD153', Cena: 70.89}),
       (:Bilet {KodBiletu: 'NIE210', Cena: 139.0}),
       (:Bilet {KodBiletu: 'BIM239', Cena: 90.35}),
       (:Bilet {KodBiletu: 'YVY257', Cena: 69.5}),
       (:Bilet {KodBiletu: 'QZS315', Cena: 144.36}),
       (:Bilet {KodBiletu: 'HHC332', Cena: 93.83}),
       (:Bilet {KodBiletu: 'IBP359', Cena: 72.18}),
       (:Bilet {KodBiletu: 'PFW415', Cena: 121.02}),
       (:Bilet {KodBiletu: 'HMF431', Cena: 78.66}),
       (:Bilet {KodBiletu: 'EOM457', Cena: 60.51}),
       (:Bilet {KodBiletu: 'SGD512', Cena: 142.76}),
       (:Bilet {KodBiletu: 'LEJ535', Cena: 92.79}),
       (:Bilet {KodBiletu: 'WTX553', Cena: 71.38}),
       (:Bilet {KodBiletu: 'GOQ610', Cena: 160.18}),
       (:Bilet {KodBiletu: 'GGR638', Cena: 104.12}),
       (:Bilet {KodBiletu: 'WBP655', Cena: 80.09}),
       (:Bilet {KodBiletu: 'WEZ715', Cena: 121.54}),
       (:Bilet {KodBiletu: 'FHQ738', Cena: 79.0}),
       (:Bilet {KodBiletu: 'KZD756', Cena: 60.77}),
       (:Bilet {KodBiletu: 'IVV812', Cena: 159.82}),
       (:Bilet {KodBiletu: 'DEX838', Cena: 103.88}),
       (:Bilet {KodBiletu: 'GAL850', Cena: 79.91}),
       (:Bilet {KodBiletu: 'IJE910', Cena: 136.18}),
       (:Bilet {KodBiletu: 'QRS931', Cena: 88.52}),
       (:Bilet {KodBiletu: 'UJG957', Cena: 68.09}),
       (:Bilet {KodBiletu: 'DTE018', Cena: 167.04}),
       (:Bilet {KodBiletu: 'EQC031', Cena: 108.58}),
       (:Bilet {KodBiletu: 'YRA053', Cena: 83.52});

