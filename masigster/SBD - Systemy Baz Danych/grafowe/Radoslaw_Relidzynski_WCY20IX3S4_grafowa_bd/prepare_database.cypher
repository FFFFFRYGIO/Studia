MATCH (n) DETACH DELETE n;
CALL apoc.schema.assert({}, {});
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

// Znizka

CREATE INDEX FOR (z:Znizka) ON (z.RodzajZnizki);

// Klient

CREATE INDEX FOR (k:Klient) ON (k.NrKlienta);

// Lotnisko

CREATE INDEX FOR (l:Lotnisko) ON (l.Nazwa);

// Model

CREATE INDEX FOR (m:Model) ON (m.Nazwa);

// Pracownik

CREATE INDEX FOR (p:Pracownik) ON (p.NrPracownika);

// Samolot

CREATE INDEX FOR (s:Samolot) ON (s.NrSamolotu);

// Lot

CREATE INDEX FOR (l:Lot) ON (l.NrLotu);

// Bilet

CREATE INDEX FOR (b:Bilet) ON (b.KodBiletu);
// Znizka

CREATE CONSTRAINT FOR (z:Znizka) REQUIRE (z.RodzajZnizki) IS NOT NULL;
CREATE CONSTRAINT FOR (z:Znizka) REQUIRE (z.RodzajZnizki) IS TYPED STRING;

CREATE CONSTRAINT FOR (z:Znizka) REQUIRE (z.ProcentUmazany) IS NOT NULL;
CREATE CONSTRAINT FOR (z:Znizka) REQUIRE (z.ProcentUmazany) IS TYPED INT;

// Klient

CREATE CONSTRAINT FOR (k:Klient) REQUIRE (k.NrKlienta) IS NOT NULL;
CREATE CONSTRAINT FOR (k:Klient) REQUIRE (k.NrKlienta) IS TYPED INT;

CREATE CONSTRAINT FOR (k:Klient) REQUIRE (k.Imie) IS NOT NULL;
CREATE CONSTRAINT FOR (k:Klient) REQUIRE (k.Imie) IS TYPED STRING;

CREATE CONSTRAINT FOR (k:Klient) REQUIRE (k.Nazwisko) IS NOT NULL;
CREATE CONSTRAINT FOR (k:Klient) REQUIRE (k.Nazwisko) IS TYPED STRING;

CREATE CONSTRAINT FOR (k:Klient) REQUIRE (k.DataUrodzenia) IS NOT NULL;
CREATE CONSTRAINT FOR (k:Klient) REQUIRE (k.DataUrodzenia) IS TYPED DATE;

CREATE CONSTRAINT FOR (k:Klient) REQUIRE (k.Plec) IS NOT NULL;
CREATE CONSTRAINT FOR (k:Klient) REQUIRE (k.Plec) IS TYPED STRING;

// Lotnisko

CREATE CONSTRAINT FOR (l:Lotnisko) REQUIRE (l.Nazwa) IS NOT NULL;
CREATE CONSTRAINT FOR (l:Lotnisko) REQUIRE (l.Nazwa) IS TYPED STRING;

CREATE CONSTRAINT FOR (l:Lotnisko) REQUIRE (l.KrajPolozenia) IS NOT NULL;
CREATE CONSTRAINT FOR (l:Lotnisko) REQUIRE (l.KrajPolozenia) IS TYPED STRING;

// Model

CREATE CONSTRAINT FOR (m:Model) REQUIRE (m.Nazwa) IS NOT NULL;
CREATE CONSTRAINT FOR (m:Model) REQUIRE (m.Nazwa) IS TYPED STRING;

// Pracownik

CREATE CONSTRAINT FOR (p:Pracownik) REQUIRE (p.NrPracownika) IS NOT NULL;
CREATE CONSTRAINT FOR (p:Pracownik) REQUIRE (p.NrPracownika) IS TYPED INT;

CREATE CONSTRAINT FOR (p:Pracownik) REQUIRE (p.Imie) IS NOT NULL;
CREATE CONSTRAINT FOR (p:Pracownik) REQUIRE (p.Imie) IS TYPED STRING;

CREATE CONSTRAINT FOR (p:Pracownik) REQUIRE (p.Nazwisko) IS NOT NULL;
CREATE CONSTRAINT FOR (p:Pracownik) REQUIRE (p.Nazwisko) IS TYPED STRING;

CREATE CONSTRAINT FOR (p:Pracownik) REQUIRE (p.DataUrodzenia) IS NOT NULL;
CREATE CONSTRAINT FOR (p:Pracownik) REQUIRE (p.DataUrodzenia) IS TYPED DATE;

// Samolot

CREATE CONSTRAINT FOR (s:Samolot) REQUIRE (s.NrSamolotu) IS NOT NULL;
CREATE CONSTRAINT FOR (s:Samolot) REQUIRE (s.NrSamolotu) IS TYPED INT;

CREATE CONSTRAINT FOR (s:Samolot) REQUIRE (s.RokProdukcji) IS NOT NULL;
CREATE CONSTRAINT FOR (s:Samolot) REQUIRE (s.RokProdukcji) IS TYPED INT;

CREATE CONSTRAINT FOR (s:Samolot) REQUIRE (s.Model) IS NOT NULL;
CREATE CONSTRAINT FOR (s:Samolot) REQUIRE (s.Model) IS TYPED STRING;

// Lot

CREATE CONSTRAINT FOR (l:Lot) REQUIRE (l.NrLotu) IS NOT NULL;
CREATE CONSTRAINT FOR (l:Lot) REQUIRE (l.NrLotu) IS TYPED INT;

CREATE CONSTRAINT FOR (l:Lot) REQUIRE (l.DataLotu) IS NOT NULL;
CREATE CONSTRAINT FOR (l:Lot) REQUIRE (l.DataLotu) IS TYPED DATE;

CREATE CONSTRAINT FOR (l:Lot) REQUIRE (l.CzasLotuMin) IS NOT NULL;
CREATE CONSTRAINT FOR (l:Lot) REQUIRE (l.CzasLotuMin) IS TYPED INT;

// Miejsce

CREATE CONSTRAINT FOR (m:Miejsce) REQUIRE (m.NrMiejsca) IS NOT NULL;
CREATE CONSTRAINT FOR (m:Miejsce) REQUIRE (m.NrMiejsca) IS TYPED INT;

CREATE CONSTRAINT FOR (m:Miejsce) REQUIRE (m.Klasa) IS NOT NULL;
CREATE CONSTRAINT FOR (m:Miejsce) REQUIRE (m.Klasa) IS TYPED STRING;

CREATE CONSTRAINT FOR (m:Miejsce) REQUIRE (m.NrSamolotu) IS NOT NULL;
CREATE CONSTRAINT FOR (m:Miejsce) REQUIRE (m.NrSamolotu) IS TYPED INT;

// Bilet

CREATE CONSTRAINT FOR (b:Bilet) REQUIRE (b.KodBiletu) IS NOT NULL;
CREATE CONSTRAINT FOR (b:Bilet) REQUIRE (b.KodBiletu) IS TYPED STRING;

CREATE CONSTRAINT FOR (b:Bilet) REQUIRE (b.Cena) IS NOT NULL;
CREATE CONSTRAINT FOR (b:Bilet) REQUIRE (b.Cena) IS TYPED FLOAT;




// Klient MA_ZNIZKE -> Znizka

MATCH (k:Klient {NrKlienta: 1}), (z:Znizka {RodzajZnizki: 'student'})
CREATE (k)-[:MA_ZNIZKE]->(z);

MATCH (k:Klient {NrKlienta: 2}), (z:Znizka {RodzajZnizki: 'rodzinna'})
CREATE (k)-[:MA_ZNIZKE]->(z);

MATCH (k:Klient {NrKlienta: 4}), (z:Znizka {RodzajZnizki: 'student'})
CREATE (k)-[:MA_ZNIZKE]->(z);

MATCH (k:Klient {NrKlienta: 6}), (z:Znizka {RodzajZnizki: 'student'})
CREATE (k)-[:MA_ZNIZKE]->(z);

MATCH (k:Klient {NrKlienta: 7}), (z:Znizka {RodzajZnizki: 'krwiodawca'})
CREATE (k)-[:MA_ZNIZKE]->(z);

MATCH (k:Klient {NrKlienta: 8}), (z:Znizka {RodzajZnizki: 'rodzinna'})
CREATE (k)-[:MA_ZNIZKE]->(z);

MATCH (k:Klient {NrKlienta: 10}), (z:Znizka {RodzajZnizki: 'rodzinna'})
CREATE (k)-[:MA_ZNIZKE]->(z);

// Pracownik MA_LICENCJE -> Model

MATCH (p1:Pracownik {Nazwisko: 'Szuszkiewicz'}), (m3:Model {Nazwa: 'DHC-6 Twin Otter'})
CREATE (p1)-[:MA_LICENCJE]->(m3);

MATCH (p1:Pracownik {Nazwisko: 'Szuszkiewicz'}), (m1:Model {Nazwa: 'Boeing 787-8 Dreamliner'})
CREATE (p1)-[:MA_LICENCJE]->(m1);

MATCH (p1:Pracownik {Nazwisko: 'Szuszkiewicz'}), (m4:Model {Nazwa: 'Antonov AN-225 Mrija'})
CREATE (p1)-[:MA_LICENCJE]->(m4);

MATCH (p2:Pracownik {Nazwisko: 'Gała'}), (m10:Model {Nazwa: 'C-54D Skymaster'})
CREATE (p2)-[:MA_LICENCJE]->(m10);

MATCH (p2:Pracownik {Nazwisko: 'Gała'}), (m1:Model {Nazwa: 'Boeing 787-8 Dreamliner'})
CREATE (p2)-[:MA_LICENCJE]->(m1);

MATCH (p2:Pracownik {Nazwisko: 'Gała'}), (m8:Model {Nazwa: 'Concorde'})
CREATE (p2)-[:MA_LICENCJE]->(m8);

MATCH (p3:Pracownik {Nazwisko: 'Świerczewski'}), (m7:Model {Nazwa: 'A380-800 British Airways'})
CREATE (p3)-[:MA_LICENCJE]->(m7);

MATCH (p3:Pracownik {Nazwisko: 'Świerczewski'}), (m8:Model {Nazwa: 'Concorde'})
CREATE (p3)-[:MA_LICENCJE]->(m8);

MATCH (p3:Pracownik {Nazwisko: 'Świerczewski'}), (m3:Model {Nazwa: 'DHC-6 Twin Otter'})
CREATE (p3)-[:MA_LICENCJE]->(m3);

MATCH (p4:Pracownik {Nazwisko: 'Kozik'}), (m2:Model {Nazwa: 'Boeing 747-200'})
CREATE (p4)-[:MA_LICENCJE]->(m2);

MATCH (p4:Pracownik {Nazwisko: 'Kozik'}), (m8:Model {Nazwa: 'Concorde'})
CREATE (p4)-[:MA_LICENCJE]->(m8);

MATCH (p4:Pracownik {Nazwisko: 'Kozik'}), (m4:Model {Nazwa: 'Antonov AN-225 Mrija'})
CREATE (p4)-[:MA_LICENCJE]->(m4);

// Samolot REALIZUJE -> Lot
// Lot LOTNISKO_STARTOWE -> Lotnisko
// Lot LOTNISKO_KONCOWE -> Lotnisko

MATCH (lot1:Lot {NrLotu: 1}), (samolot3:Samolot {NrSamolotu: 3}),
      (lotnisko5:Lotnisko {Nazwa: 'Rzym Fiumicino'}), (lotnisko1:Lotnisko {Nazwa: 'Londyn Heathrow'})
CREATE (samolot3)-[:REALIZUJE]->(lot1),
       (lot1)-[:LOTNISKO_STARTOWE]->(lotnisko5),
       (lot1)-[:LOTNISKO_KONCOWE]->(lotnisko1);

MATCH (lot2:Lot {NrLotu: 2}), (samolot2:Samolot {NrSamolotu: 2}),
      (lotnisko8:Lotnisko {Nazwa: 'Barcelona Airport'}), (lotnisko3:Lotnisko {Nazwa: 'Frankfurt International Airport'})
CREATE (samolot2)-[:REALIZUJE]->(lot2),
       (lot2)-[:LOTNISKO_STARTOWE]->(lotnisko8),
       (lot2)-[:LOTNISKO_KONCOWE]->(lotnisko3);

MATCH (lot3:Lot {NrLotu: 3}), (samolot10:Samolot {NrSamolotu: 10}),
      (lotnisko7:Lotnisko {Nazwa: 'Monachium'}), (lotnisko2:Lotnisko {Nazwa: 'Paryż Charles de Gaulle'})
CREATE (samolot10)-[:REALIZUJE]->(lot3),
       (lot3)-[:LOTNISKO_STARTOWE]->(lotnisko7),
       (lot3)-[:LOTNISKO_KONCOWE]->(lotnisko2);

MATCH (lot4:Lot {NrLotu: 4}), (samolot1:Samolot {NrSamolotu: 1}),
      (lotnisko6:Lotnisko {Nazwa: 'Madryt'}), (lotnisko3:Lotnisko {Nazwa: 'Frankfurt International Airport'})
CREATE (samolot1)-[:REALIZUJE]->(lot4),
       (lot4)-[:LOTNISKO_STARTOWE]->(lotnisko6),
       (lot4)-[:LOTNISKO_KONCOWE]->(lotnisko3);

MATCH (lot5:Lot {NrLotu: 5}), (samolot8:Samolot {NrSamolotu: 8}),
      (lotnisko7:Lotnisko {Nazwa: 'Monachium'}), (lotnisko5:Lotnisko {Nazwa: 'Rzym Fiumicino'})
CREATE (samolot8)-[:REALIZUJE]->(lot5),
       (lot5)-[:LOTNISKO_STARTOWE]->(lotnisko7),
       (lot5)-[:LOTNISKO_KONCOWE]->(lotnisko5);

MATCH (lot6:Lot {NrLotu: 6}), (samolot7:Samolot {NrSamolotu: 7}),
      (lotnisko1:Lotnisko {Nazwa: 'Londyn Heathrow'}), (lotnisko5:Lotnisko {Nazwa: 'Rzym Fiumicino'})
CREATE (samolot7)-[:REALIZUJE]->(lot6),
       (lot6)-[:LOTNISKO_STARTOWE]->(lotnisko1),
       (lot6)-[:LOTNISKO_KONCOWE]->(lotnisko5);

MATCH (lot7:Lot {NrLotu: 7}), (samolot3:Samolot {NrSamolotu: 3}),
      (lotnisko3:Lotnisko {Nazwa: 'Frankfurt International Airport'}), (lotnisko4:Lotnisko {Nazwa: 'Amsterdam Airport'})
CREATE (samolot3)-[:REALIZUJE]->(lot7),
       (lot7)-[:LOTNISKO_STARTOWE]->(lotnisko3),
       (lot7)-[:LOTNISKO_KONCOWE]->(lotnisko4);

MATCH (lot8:Lot {NrLotu: 8}), (samolot4:Samolot {NrSamolotu: 4}),
      (lotnisko6:Lotnisko {Nazwa: 'Madryt'}), (lotnisko3:Lotnisko {Nazwa: 'Frankfurt International Airport'})
CREATE (samolot4)-[:REALIZUJE]->(lot8),
       (lot8)-[:LOTNISKO_STARTOWE]->(lotnisko6),
       (lot8)-[:LOTNISKO_KONCOWE]->(lotnisko3);

MATCH (lot9:Lot {NrLotu: 9}), (samolot2:Samolot {NrSamolotu: 2}),
      (lotnisko8:Lotnisko {Nazwa: 'Barcelona Airport'}), (lotnisko7:Lotnisko {Nazwa: 'Monachium'})
CREATE (samolot2)-[:REALIZUJE]->(lot9),
       (lot9)-[:LOTNISKO_STARTOWE]->(lotnisko8),
       (lot9)-[:LOTNISKO_KONCOWE]->(lotnisko7);

MATCH (lot10:Lot {NrLotu: 10}), (samolot4:Samolot {NrSamolotu: 4}),
      (lotnisko2:Lotnisko {Nazwa: 'Paryż Charles de Gaulle'}), (lotnisko3:Lotnisko {Nazwa: 'Frankfurt International Airport'})
CREATE (samolot4)-[:REALIZUJE]->(lot10),
       (lot10)-[:LOTNISKO_STARTOWE]->(lotnisko2),
       (lot10)-[:LOTNISKO_KONCOWE]->(lotnisko3);

// Pracownik ROLA_W_LOCIE -> Lot

MATCH (l1:Lot {NrLotu: 1}), (p3:Pracownik {NrPracownika: 3})
CREATE (p3)-[:ROLA_W_LOCIE {Rola: 'pilot'}]->(l1);

MATCH (l1:Lot {NrLotu: 1}), (p5:Pracownik {NrPracownika: 5})
CREATE (p5)-[:ROLA_W_LOCIE {Rola: 'steward'}]->(l1);

MATCH (l1:Lot {NrLotu: 1}), (p10:Pracownik {NrPracownika: 10})
CREATE (p10)-[:ROLA_W_LOCIE {Rola: 'mechanik'}]->(l1);

MATCH (l2:Lot {NrLotu: 2}), (p4:Pracownik {NrPracownika: 4})
CREATE (p4)-[:ROLA_W_LOCIE {Rola: 'pilot'}]->(l2);

MATCH (l2:Lot {NrLotu: 2}), (p6:Pracownik {NrPracownika: 6})
CREATE (p6)-[:ROLA_W_LOCIE {Rola: 'steward'}]->(l2);

MATCH (l2:Lot {NrLotu: 2}), (p8:Pracownik {NrPracownika: 8})
CREATE (p8)-[:ROLA_W_LOCIE {Rola: 'mechanik'}]->(l2);

MATCH (l3:Lot {NrLotu: 3}), (p2:Pracownik {NrPracownika: 2})
CREATE (p2)-[:ROLA_W_LOCIE {Rola: 'pilot'}]->(l3);

MATCH (l3:Lot {NrLotu: 3}), (p8:Pracownik {NrPracownika: 8})
CREATE (p8)-[:ROLA_W_LOCIE {Rola: 'steward'}]->(l3);

MATCH (l3:Lot {NrLotu: 3}), (p10:Pracownik {NrPracownika: 10})
CREATE (p10)-[:ROLA_W_LOCIE {Rola: 'mechanik'}]->(l3);

MATCH (l4:Lot {NrLotu: 4}), (p2:Pracownik {NrPracownika: 2})
CREATE (p2)-[:ROLA_W_LOCIE {Rola: 'pilot'}]->(l4);

MATCH (l4:Lot {NrLotu: 4}), (p6:Pracownik {NrPracownika: 6})
CREATE (p6)-[:ROLA_W_LOCIE {Rola: 'steward'}]->(l4);

MATCH (l4:Lot {NrLotu: 4}), (p10:Pracownik {NrPracownika: 10})
CREATE (p10)-[:ROLA_W_LOCIE {Rola: 'mechanik'}]->(l4);

MATCH (l5:Lot {NrLotu: 5}), (p2:Pracownik {NrPracownika: 2})
CREATE (p2)-[:ROLA_W_LOCIE {Rola: 'pilot'}]->(l5);

MATCH (l5:Lot {NrLotu: 5}), (p7:Pracownik {NrPracownika: 7})
CREATE (p7)-[:ROLA_W_LOCIE {Rola: 'steward'}]->(l5);

MATCH (l5:Lot {NrLotu: 5}), (p10:Pracownik {NrPracownika: 10})
CREATE (p10)-[:ROLA_W_LOCIE {Rola: 'mechanik'}]->(l5);

MATCH (l6:Lot {NrLotu: 6}), (p3:Pracownik {NrPracownika: 3})
CREATE (p3)-[:ROLA_W_LOCIE {Rola: 'pilot'}]->(l6);

MATCH (l6:Lot {NrLotu: 6}), (p7:Pracownik {NrPracownika: 7})
CREATE (p7)-[:ROLA_W_LOCIE {Rola: 'steward'}]->(l6);

MATCH (l6:Lot {NrLotu: 6}), (p10:Pracownik {NrPracownika: 10})
CREATE (p10)-[:ROLA_W_LOCIE {Rola: 'mechanik'}]->(l6);

MATCH (l7:Lot {NrLotu: 7}), (p3:Pracownik {NrPracownika: 3})
CREATE (p3)-[:ROLA_W_LOCIE {Rola: 'pilot'}]->(l7);

MATCH (l7:Lot {NrLotu: 7}), (p7:Pracownik {NrPracownika: 7})
CREATE (p7)-[:ROLA_W_LOCIE {Rola: 'steward'}]->(l7);

MATCH (l7:Lot {NrLotu: 7}), (p10:Pracownik {NrPracownika: 10})
CREATE (p10)-[:ROLA_W_LOCIE {Rola: 'mechanik'}]->(l7);

MATCH (l8:Lot {NrLotu: 8}), (p1:Pracownik {NrPracownika: 1})
CREATE (p1)-[:ROLA_W_LOCIE {Rola: 'pilot'}]->(l8);

MATCH (l8:Lot {NrLotu: 8}), (p6:Pracownik {NrPracownika: 6})
CREATE (p6)-[:ROLA_W_LOCIE {Rola: 'steward'}]->(l8);

MATCH (l8:Lot {NrLotu: 8}), (p10:Pracownik {NrPracownika: 10})
CREATE (p10)-[:ROLA_W_LOCIE {Rola: 'mechanik'}]->(l8);

MATCH (l9:Lot {NrLotu: 9}), (p4:Pracownik {NrPracownika: 4})
CREATE (p4)-[:ROLA_W_LOCIE {Rola: 'pilot'}]->(l9);

MATCH (l9:Lot {NrLotu: 9}), (p5:Pracownik {NrPracownika: 5})
CREATE (p5)-[:ROLA_W_LOCIE {Rola: 'steward'}]->(l9);

MATCH (l9:Lot {NrLotu: 9}), (p10:Pracownik {NrPracownika: 10})
CREATE (p10)-[:ROLA_W_LOCIE {Rola: 'mechanik'}]->(l9);

MATCH (l10:Lot {NrLotu: 10}), (p1:Pracownik {NrPracownika: 1})
CREATE (p1)-[:ROLA_W_LOCIE {Rola: 'pilot'}]->(l10);

MATCH (l10:Lot {NrLotu: 10}), (p8:Pracownik {NrPracownika: 8})
CREATE (p8)-[:ROLA_W_LOCIE {Rola: 'steward'}]->(l10);

MATCH (l10:Lot {NrLotu: 10}), (p10:Pracownik {NrPracownika: 10})
CREATE (p10)-[:ROLA_W_LOCIE {Rola: 'mechanik'}]->(l10);

// Samolot MA_MIEJSCE -> Miejsce

MATCH (m:Miejsce), (s:Samolot)
WHERE m.NrSamolotu = s.NrSamolotu
CREATE (s)-[:MA_MIEJSCE]->(m);

// Bilet NA_LOT -> Lot
// Bilet NA_MIEJSCE -> Miejsce
// Klient MA_BILET -> Bilet

MATCH (b:Bilet {KodBiletu: 'NZY114'}), (l:Lot {NrLotu: 1}), (m:Miejsce {NrMiejsca: 1}), (k:Klient {NrKlienta: 4}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'RND132'}), (l:Lot {NrLotu: 1}), (m:Miejsce {NrMiejsca: 2}), (k:Klient {NrKlienta: 2}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'YMD153'}), (l:Lot {NrLotu: 1}), (m:Miejsce {NrMiejsca: 4}), (k:Klient {NrKlienta: 3}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'NIE210'}), (l:Lot {NrLotu: 2}), (m:Miejsce {NrMiejsca: 1}), (k:Klient {NrKlienta: 10}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'BIM239'}), (l:Lot {NrLotu: 2}), (m:Miejsce {NrMiejsca: 3}), (k:Klient {NrKlienta: 9}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'YVY257'}), (l:Lot {NrLotu: 2}), (m:Miejsce {NrMiejsca: 5}), (k:Klient {NrKlienta: 7}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'QZS315'}), (l:Lot {NrLotu: 3}), (m:Miejsce {NrMiejsca: 1}), (k:Klient {NrKlienta: 5}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'HHC332'}), (l:Lot {NrLotu: 3}), (m:Miejsce {NrMiejsca: 3}), (k:Klient {NrKlienta: 2}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'IBP359'}), (l:Lot {NrLotu: 3}), (m:Miejsce {NrMiejsca: 5}), (k:Klient {NrKlienta: 9}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'PFW415'}), (l:Lot {NrLotu: 4}), (m:Miejsce {NrMiejsca: 1}), (k:Klient {NrKlienta: 5}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'HMF431'}), (l:Lot {NrLotu: 4}), (m:Miejsce {NrMiejsca: 3}), (k:Klient {NrKlienta: 1}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'EOM457'}), (l:Lot {NrLotu: 4}), (m:Miejsce {NrMiejsca: 4}), (k:Klient {NrKlienta: 7}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'SGD512'}), (l:Lot {NrLotu: 5}), (m:Miejsce {NrMiejsca: 1}), (k:Klient {NrKlienta: 2}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'LEJ535'}), (l:Lot {NrLotu: 5}), (m:Miejsce {NrMiejsca: 3}), (k:Klient {NrKlienta: 5}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'WTX553'}), (l:Lot {NrLotu: 5}), (m:Miejsce {NrMiejsca: 4}), (k:Klient {NrKlienta: 3}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'GOQ610'}), (l:Lot {NrLotu: 6}), (m:Miejsce {NrMiejsca: 1}), (k:Klient {NrKlienta: 10}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'GGR638'}), (l:Lot {NrLotu: 6}), (m:Miejsce {NrMiejsca: 3}), (k:Klient {NrKlienta: 8}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'WBP655'}), (l:Lot {NrLotu: 6}), (m:Miejsce {NrMiejsca: 5}), (k:Klient {NrKlienta: 5}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'WEZ715'}), (l:Lot {NrLotu: 7}), (m:Miejsce {NrMiejsca: 1}), (k:Klient {NrKlienta: 5}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'FHQ738'}), (l:Lot {NrLotu: 7}), (m:Miejsce {NrMiejsca: 3}), (k:Klient {NrKlienta: 8}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'KZD756'}), (l:Lot {NrLotu: 7}), (m:Miejsce {NrMiejsca: 5}), (k:Klient {NrKlienta: 6}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'IVV812'}), (l:Lot {NrLotu: 8}), (m:Miejsce {NrMiejsca: 1}), (k:Klient {NrKlienta: 2}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'DEX838'}), (l:Lot {NrLotu: 8}), (m:Miejsce {NrMiejsca: 3}), (k:Klient {NrKlienta: 8}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'GAL850'}), (l:Lot {NrLotu: 8}), (m:Miejsce {NrMiejsca: 4}), (k:Klient {NrKlienta: 10}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'IJE910'}), (l:Lot {NrLotu: 9}), (m:Miejsce {NrMiejsca: 1}), (k:Klient {NrKlienta: 10}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'QRS931'}), (l:Lot {NrLotu: 9}), (m:Miejsce {NrMiejsca: 3}), (k:Klient {NrKlienta: 1}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'UJG957'}), (l:Lot {NrLotu: 9}), (m:Miejsce {NrMiejsca: 5}), (k:Klient {NrKlienta: 7}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'DTE018'}), (l:Lot {NrLotu: 10}), (m:Miejsce {NrMiejsca: 1}), (k:Klient {NrKlienta: 8}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'EQC031'}), (l:Lot {NrLotu: 10}), (m:Miejsce {NrMiejsca: 3}), (k:Klient {NrKlienta: 1}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);

MATCH (b:Bilet {KodBiletu: 'YRA053'}), (l:Lot {NrLotu: 10}), (m:Miejsce {NrMiejsca: 5}), (k:Klient {NrKlienta: 3}),
      (s:Samolot)-[:REALIZUJE]->(l), (s)-[:MA_MIEJSCE]->(m)
CREATE (b)-[:NA_LOT]->(l),
       (b)-[:NA_MIEJSCE]->(m),
       (k)-[:MA_BILET]->(b);
