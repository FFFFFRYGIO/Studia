// 1 Wyświetl klientów, którzy mają kupiony bilet na lot samolotem z serii "Boeing"

MATCH (k:Klient)-[r1:MA_BILET]->(b:Bilet)-[r2:NA_LOT]->(l:Lot)<-[r3:REALIZUJE]-(s:Samolot)
WHERE s.Model CONTAINS 'Boeing'
RETURN k, r1, b, r2, l, r3, s

// 2 Wyświetl pracowników, którzy pełnili więcej niż jedną rolę w różnych lotach

MATCH (p:Pracownik)-[r1:ROLA_W_LOCIE]->(l:Lot)
WITH p, COUNT(DISTINCT l) AS num_lots
WHERE num_lots > 1
RETURN p

// 3 Wyświetl wszystkie samoloty na które bilet ma klient o numerze 1

MATCH p = (k:Klient {NrKlienta: 1})-[*3]-(s:Samolot)
RETURN p

// Długie i błędne zapytanie, ponieważ szuka wszystkich ścieżek z samolotami, również tymi, na które nie ma biletu
// MATCH p = (k:Klient {NrKlienta: 1})-[*]-(s:Samolot) RETURN p

// 4 Wyświetl połączenia dla klientów, którzy mają bilet na ten sam lot

MATCH p = (k1:Klient)-[:MA_BILET]->(b1:Bilet)-[:NA_LOT]->(l:Lot)<-[:NA_LOT]-(b2:Bilet)<-[:MA_BILET]-(k2:Klient)
WHERE k1 <> k2 AND (k1.NrKlienta = 5 OR k2.NrKlienta = 5)
RETURN p

// 5 Wyświetlenie dla każdego pracownika z jakimi innymi pracownikami biorą udział w locie

WITH 2 AS minLength
MATCH (p1:Pracownik)-[:ROLA_W_LOCIE]->(l:Lot)<-[:ROLA_W_LOCIE]-(p2:Pracownik)
WHERE p1 <> p2
WITH p1, p2, shortestPath((p1)-[:ROLA_W_LOCIE*]-(p2)) AS path
WHERE length(path) = minLength
RETURN path

// 6 Przejrzenie połączeń między klientem o numerze 1 a pracownikami, długości węzłów od 4 do 6

MATCH p = (start:Klient {NrKlienta: 1})-[*2..4]-(end:Pracownik)
RETURN p
