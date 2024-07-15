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
