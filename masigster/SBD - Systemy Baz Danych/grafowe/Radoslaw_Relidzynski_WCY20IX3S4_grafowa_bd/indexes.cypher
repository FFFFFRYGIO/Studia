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
