-- TEST trg_urodziny
INSERT INTO KLIENT (IMIE, NAZWISKO, DATA_URODZENIA, RODZAJ_ZNIZKI, PLEC) 
VALUES ('Dzisiaj', 'Urodzony', CAST(DATEADD(YEAR, -18, GETDATE()) AS DATETIME), NULL, 'M');

INSERT INTO KLIENT (IMIE, NAZWISKO, DATA_URODZENIA, RODZAJ_ZNIZKI, PLEC) 
VALUES
	('Anna', 'Kowalska', CAST(DATEADD(YEAR, -40, GETDATE()) AS DATETIME), NULL, 'M'),
	('Jan', 'Nowak', CAST(DATEADD(YEAR, -30, GETDATE()) AS DATETIME), NULL, 'M'),
	('Maria', 'Wi?niewska', CAST(DATEADD(YEAR, -20, GETDATE()) AS DATETIME), NULL, 'M'),
	('Piotr', 'Zieli?ski', CAST(DATEADD(YEAR, -30, GETDATE()) AS DATETIME), NULL, 'M');
