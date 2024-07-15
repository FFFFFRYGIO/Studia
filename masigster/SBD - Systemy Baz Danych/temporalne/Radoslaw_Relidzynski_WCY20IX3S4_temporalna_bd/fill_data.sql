USE lotniska_europy;

--ZNIZKA

INSERT INTO ZNIZKA (RODZAJ_ZNIZKI, PROCENT_UMAZANY) 
VALUES ('rodzinna', 37);

INSERT INTO ZNIZKA (RODZAJ_ZNIZKI, PROCENT_UMAZANY) 
VALUES ('student', 50);

INSERT INTO ZNIZKA (RODZAJ_ZNIZKI, PROCENT_UMAZANY) 
VALUES ('krwiodawca', 75);

--KLIENT

ALTER TABLE klient SET (SYSTEM_VERSIONING = OFF);
ALTER TABLE klient DROP PERIOD FOR SYSTEM_TIME;
GO

INSERT INTO KLIENTHistory (NR_KLIENTA, IMIE, NAZWISKO, DATA_URODZENIA, RODZAJ_ZNIZKI, PLEC, SysStartTime, SysEndTime) 
VALUES 
    (1, 'Kamil', 'Madaj', CAST('2000-12-01' AS DATETIME), 'student', 'M', '2020-11-11 11:00:00.0000000', '2020-11-11 11:59:59.9999999'),
    (2, 'Emilia', 'Książkiewicz', CAST('1990-02-06' AS DATETIME), NULL, 'K', '2022-04-08 15:43:23.4373858', '2022-05-06 14:32:56.9999999'),
    (3, 'Mateusz', 'Dybek', CAST('1993-12-06' AS DATETIME), NULL, 'M', '2021-10-30 16:22:23.7647854', '2021-10-30 16:30:23.7999999'),
    (4, 'Zofia', 'Komosa', CAST('2001-05-12' AS DATETIME), 'student', 'K', '2023-05-02 22:22:22.2222222', '2023-09-30 18:31:22.1234567'),
    (4, 'Zofia', 'Komosa', CAST('2001-05-12' AS DATETIME), 'student', 'M', '2023-09-30 18:31:22.1234568', '2024-01-30 13:11:22.3333333');

DECLARE @MaxDate DATETIME2;
SET @MaxDate = '9999-12-31 23:59:59.9999999';

INSERT INTO KLIENT (IMIE, NAZWISKO, DATA_URODZENIA, RODZAJ_ZNIZKI, PLEC, SysStartTime, SysEndTime) 
VALUES ('Kamil', 'Madajski', CAST('01-12-2000' AS DATETIME), 'student', 'M', '2020-11-11 12:00:00.0000000', @MaxDate);

INSERT INTO KLIENT (IMIE, NAZWISKO, DATA_URODZENIA, RODZAJ_ZNIZKI, PLEC, SysStartTime, SysEndTime) 
VALUES ('Emilia', 'Książkiewicz', CAST('06-02-1990' AS DATETIME), 'rodzinna', 'K', '2022-05-06 14:32:57.0000000', @MaxDate);

INSERT INTO KLIENT (IMIE, NAZWISKO, DATA_URODZENIA, RODZAJ_ZNIZKI, PLEC, SysStartTime, SysEndTime) 
VALUES ('Mateusz', 'Dybek', CAST('12-06-1993' AS DATETIME), NULL, 'M', '2021-10-30 16:30:23.8000000', @MaxDate);

INSERT INTO KLIENT (IMIE, NAZWISKO, DATA_URODZENIA, RODZAJ_ZNIZKI, PLEC, SysStartTime, SysEndTime) 
VALUES ('Zofia', 'Komosa', CAST('12-05-2001' AS DATETIME), 'student', 'K', '2024-01-30 13:11:22.3333334', @MaxDate);

INSERT INTO KLIENT (IMIE, NAZWISKO, DATA_URODZENIA, RODZAJ_ZNIZKI, PLEC, SysStartTime, SysEndTime) 
VALUES ('Krystyna', 'Czarniak', CAST('05-12-1992' AS DATETIME), NULL, 'K', '2019-07-17 17:25:59.3499545', @MaxDate);

INSERT INTO KLIENT (IMIE, NAZWISKO, DATA_URODZENIA, RODZAJ_ZNIZKI, PLEC, SysStartTime, SysEndTime) 
VALUES ('Janusz', 'Grzelczak', CAST('03-08-2002' AS DATETIME), 'student', 'M', '2011-10-19 10:26:25.4382803', @MaxDate);

INSERT INTO KLIENT (IMIE, NAZWISKO, DATA_URODZENIA, RODZAJ_ZNIZKI, PLEC, SysStartTime, SysEndTime) 
VALUES ('Albert', 'Świątkowski', CAST('06-04-1995' AS DATETIME), 'krwiodawca', 'M', '2015-10-29 04:58:33.0182587', @MaxDate);

INSERT INTO KLIENT (IMIE, NAZWISKO, DATA_URODZENIA, RODZAJ_ZNIZKI, PLEC, SysStartTime, SysEndTime) 
VALUES ('Krzysztof', 'Cieluch', CAST('09-10-1991' AS DATETIME), 'rodzinna', 'M', '2010-10-26 22:46:41.2310482', @MaxDate);

INSERT INTO KLIENT (IMIE, NAZWISKO, DATA_URODZENIA, RODZAJ_ZNIZKI, PLEC, SysStartTime, SysEndTime) 
VALUES ('Małgorzata', 'Handzlik', CAST('11-08-2001' AS DATETIME), NULL, 'K', '2013-11-18 15:52:16.8286211', @MaxDate);

INSERT INTO KLIENT (IMIE, NAZWISKO, DATA_URODZENIA, RODZAJ_ZNIZKI, PLEC, SysStartTime, SysEndTime) 
VALUES ('Tobiasz', 'Ciszek', CAST('03-08-1996' AS DATETIME), 'rodzinna', 'M', '2013-10-04 00:57:29.0900689', @MaxDate);

INSERT INTO KLIENT (IMIE, NAZWISKO, DATA_URODZENIA, RODZAJ_ZNIZKI, PLEC, SysStartTime, SysEndTime) 
VALUES ('Dzisiaj', 'Urodzony', CAST(DATEADD(YEAR, -18, GETDATE()) AS DATETIME), NULL, 'M', DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()), 0), @MaxDate);

ALTER TABLE klient ADD PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);
ALTER TABLE klient SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.klientHistory, DATA_CONSISTENCY_CHECK = ON));
GO

--LOTNISKO

INSERT INTO LOTNISKO (NAZWA, KRAJ_POLOZENIA) 
VALUES 
	('Londyn Heathrow', 'Anglia'),
	('Paryż Charles de Gaulle', 'Francja'),
	('Frankfurt International Airport', 'Niemcy'),
	('Amsterdam Airport ', 'Holandia'),
	('Rzym Fiumicino', 'Włochy'),
	('Madryt', 'Hiszpania'),
	('Monachium', 'Niemcy'),
	('Barcelona Airport', 'Hiszpania');

--MODEL

INSERT INTO MODEL (NAZWA) 
VALUES
	('Boeing 787-8 Dreamliner'),
	('Boeing 747-200'),
	('DHC-6 Twin Otter'),
	('Antonov AN-225 Mrija'),
	('Boeing 777-300ER'),
	('DC-4 Balair'),
	('A380-800 British Airways'),
	('Concorde'),
	('Boeing 747-300'),
	('C-54D Skymaster');

--PRACOWNIK

INSERT INTO PRACOWNIK (IMIE, NAZWISKO, DATA_URODZENIA) 
VALUES
	('Mariusz', 'Szuszkiewicz', CAST('01-07-1985' AS DATETIME)),
	('Piotr', 'Gała', CAST('01-25-1981' AS DATETIME)),
	('Waldemar', 'Świerczewski', CAST('11-14-1992' AS DATETIME)),
	('Maja', 'Kozik', CAST('11-15-1990' AS DATETIME)),
	('Joanna', 'Krupa', CAST('07-13-1991' AS DATETIME)),
	('Natalia', 'Kortas', CAST('03-05-1983' AS DATETIME)),
	('Tomasz', 'Klasa', CAST('06-09-1981' AS DATETIME)),
	('Szymon', 'Bucior', CAST('01-02-1989' AS DATETIME)),
	('Emil', 'Mieczkowski', CAST('07-21-1982' AS DATETIME)),
	('Maria', 'Wieczorek', CAST('05-22-1990' AS DATETIME));

--LICENCJA

INSERT INTO LICENCJA (NR_PRACOWNIKA, NR_MODELU) 
VALUES
	(1, 3),
	(1, 1),
	(1, 4),
	(2, 10),
	(2, 1),
	(2, 8),
	(3, 7),
	(3, 8),
	(3, 3),
	(4, 2),
	(4, 8),
	(4, 4);

--SAMOLOT

INSERT INTO SAMOLOT (ROK_PRODUKCJI, NR_MODELU) 
VALUES
	(2013, 8),
	(2015, 2),
	(2010, 7),
	(2005, 4),
	(2008, 5),
	(2014, 1),
	(2019, 7),
	(2010, 10),
	(2013, 8),
	(2010, 1);

--LOT

ALTER TABLE lot SET (SYSTEM_VERSIONING = OFF);
ALTER TABLE lot DROP PERIOD FOR SYSTEM_TIME;
GO

INSERT INTO lotHistory (NR_LOTU, DATA_LOTU, CZAS_LOTU_MIN, NR_SAMOLOTU, LOTNISKO_STARTOWE, LOTNISKO_DOCELOWE, SysStartTime, SysEndTime) 
VALUES
	(1, CAST('04-16-2025' AS DATETIME), 60, 3, 5, 1, '2020-10-11 12:00:00.0000000', '2020-11-11 11:59:59.9999999'),
	(2, CAST('06-23-2025' AS DATETIME), 60, 2, 8, 3, '2020-10-11 12:00:00.0000000', '2020-11-11 11:59:59.9999999'),
	(3, CAST('01-13-2025' AS DATETIME), 60, 10, 7, 2, '2020-10-11 12:00:00.0000000', '2020-11-11 11:59:59.9999999'),
	(4, CAST('05-31-2025' AS DATETIME), 60, 1, 6, 3, '2020-10-11 12:00:00.0000000', '2020-11-11 11:59:59.9999999'),
	(5, CAST('01-01-2025' AS DATETIME), 60, 8, 7, 5, '2020-10-11 12:00:00.0000000', '2020-11-11 11:59:59.9999999'),
	(6, CAST('09-26-2025' AS DATETIME), 60, 7, 1, 5, '2020-10-11 12:00:00.0000000', '2020-11-11 11:59:59.9999999'),
	(7, CAST('09-23-2025' AS DATETIME), 60, 3, 3, 4, '2020-10-11 12:00:00.0000000', '2020-11-11 11:59:59.9999999'),
	(8, CAST('03-29-2025' AS DATETIME), 60, 4, 6, 3, '2020-10-11 12:00:00.0000000', '2020-11-11 11:59:59.9999999'),
	(9, CAST('07-23-2025' AS DATETIME), 60, 2, 8, 7, '2020-10-11 12:00:00.0000000', '2020-11-11 11:59:59.9999999'),
	(10, CAST('03-19-2025' AS DATETIME), 60, 4, 2, 3, '2020-10-11 12:00:00.0000000', '2020-11-11 11:59:59.9999999');

DECLARE @MaxDate DATETIME2;
SET @MaxDate = '9999-12-31 23:59:59.9999999';

INSERT INTO LOT (DATA_LOTU, CZAS_LOTU_MIN, NR_SAMOLOTU, LOTNISKO_STARTOWE, LOTNISKO_DOCELOWE, SysStartTime, SysEndTime) 
VALUES
	(CAST('04-16-2025' AS DATETIME), 240, 3, 5, 1, '2020-11-11 12:00:00.0000000', @MaxDate),
	(CAST('06-23-2025' AS DATETIME), 270, 2, 8, 3, '2020-11-11 12:00:00.0000000', @MaxDate),
	(CAST('01-13-2025' AS DATETIME), 240, 10, 7, 2, '2020-11-11 12:00:00.0000000', @MaxDate),
	(CAST('05-31-2025' AS DATETIME), 120, 1, 6, 3, '2020-11-11 12:00:00.0000000', @MaxDate),
	(CAST('01-01-2025' AS DATETIME), 150, 8, 7, 5, '2020-11-11 12:00:00.0000000', @MaxDate),
	(CAST('09-26-2025' AS DATETIME), 240, 7, 1, 5, '2020-11-11 12:00:00.0000000', @MaxDate),
	(CAST('09-23-2025' AS DATETIME), 60, 3, 3, 4, '2020-11-11 12:00:00.0000000', @MaxDate),
	(CAST('03-29-2025' AS DATETIME), 90, 4, 6, 3, '2020-11-11 12:00:00.0000000', @MaxDate),
	(CAST('07-23-2025' AS DATETIME), 60, 2, 8, 7, '2020-11-11 12:00:00.0000000', @MaxDate),
	(CAST('03-19-2025' AS DATETIME), 90, 4, 2, 3, '2020-11-11 12:00:00.0000000', @MaxDate);

ALTER TABLE lot ADD PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);
ALTER TABLE lot SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.lotHistory, DATA_CONSISTENCY_CHECK = ON));
GO

--ROLA_W_LOCIE

INSERT INTO ROLA_W_LOCIE (NR_LOTU, NR_PRACOWNIKA, ROLA) 
VALUES
	(1, 3, 'pilot'),
	(1, 5, 'steward'),
	(1, 9, 'mechanik'),
	(2, 4, 'pilot'),
	(2, 6, 'steward'),
	(2, 8, 'mechanik'),
	(3, 2, 'pilot'),
	(3, 8, 'steward'),
	(3, 9, 'mechanik'),
	(4, 2, 'pilot'),
	(4, 6, 'steward'),
	(4, 9, 'mechanik'),
	(5, 2, 'pilot'),
	(5, 7, 'steward'),
	(5, 9, 'mechanik'),
	(6, 3, 'pilot'),
	(6, 7, 'steward'),
	(6, 10, 'mechanik'),
	(7, 3, 'pilot'),
	(7, 7, 'steward'),
	(7, 10, 'mechanik'),
	(8, 1, 'pilot'),
	(8, 6, 'steward'),
	(8, 9, 'mechanik'),
	(9, 4, 'pilot'),
	(9, 5, 'steward'),
	(9, 9, 'mechanik'),
	(10, 1, 'pilot'),
	(10, 8, 'steward'),
	(10, 10, 'mechanik');

--MIEJSCE

INSERT INTO MIEJSCE (NR_MIEJSCA, KLASA, NR_SAMOLOTU) 
VALUES
	(1, 'biznes', 1),
	(2, 'pierwsza', 1),
	(3, 'pierwsza', 1),
	(4, 'ekonomiczna', 1),
	(5, 'ekonomiczna', 1),
	(1, 'biznes', 2),
	(2, 'pierwsza', 2),
	(3, 'pierwsza', 2),
	(4, 'ekonomiczna', 2),
	(5, 'ekonomiczna', 2),
	(1, 'biznes', 3),
	(2, 'pierwsza', 3),
	(3, 'pierwsza', 3),
	(4, 'ekonomiczna', 3),
	(5, 'ekonomiczna', 3),
	(1, 'biznes', 4),
	(2, 'pierwsza', 4),
	(3, 'pierwsza', 4),
	(4, 'ekonomiczna', 4),
	(5, 'ekonomiczna', 4),
	(1, 'biznes', 5),
	(2, 'pierwsza', 5),
	(3, 'pierwsza', 5),
	(4, 'ekonomiczna', 5),
	(5, 'ekonomiczna', 5),
	(1, 'biznes', 6),
	(2, 'pierwsza', 6),
	(3, 'pierwsza', 6),
	(4, 'ekonomiczna', 6),
	(5, 'ekonomiczna', 6),
	(1, 'biznes', 7),
	(2, 'pierwsza', 7),
	(3, 'pierwsza', 7),
	(4, 'ekonomiczna', 7),
	(5, 'ekonomiczna', 7),
	(1, 'biznes', 8),
	(2, 'pierwsza', 8),
	(3, 'pierwsza', 8),
	(4, 'ekonomiczna', 8),
	(5, 'ekonomiczna', 8),
	(1, 'biznes', 9),
	(2, 'pierwsza', 9),
	(3, 'pierwsza', 9),
	(4, 'ekonomiczna', 9),
	(5, 'ekonomiczna', 9),
	(1, 'biznes', 10),
	(2, 'pierwsza', 10),
	(3, 'pierwsza', 10),
	(4, 'ekonomiczna', 10),
	(5, 'ekonomiczna', 10);

--BILET

ALTER TABLE bilet SET (SYSTEM_VERSIONING = OFF);
ALTER TABLE bilet DROP PERIOD FOR SYSTEM_TIME;
GO

INSERT INTO BILETHistory (KOD_BILETU, NR_LOTU, NR_SAMOLOTU, NR_MIEJSCA, NR_KLIENTA, CENA, SysStartTime, SysEndTime) 
VALUES
    ('NZY114', 1, 3, 1, 4, 80.00, '2019-06-11 12:00:00.0000000', '2019-07-11 11:59:59.9999999'),
    ('NZY114', 1, 3, 1, 4, 90.00, '2019-07-11 12:00:00.0000000', '2019-08-11 11:59:59.9999999'),
    ('NZY114', 1, 3, 1, 4, 100.00, '2020-08-11 12:00:00.0000000', '2020-09-11 11:59:59.9999999'),
    ('NZY114', 1, 3, 1, 4, 110.00, '2020-09-11 12:00:00.0000000', '2020-10-11 11:59:59.9999999'),
    ('NZY114', 1, 3, 1, 4, 120.00, '2020-10-11 12:00:00.0000000', '2020-11-11 11:59:59.9999999'),

    ('RND132', 1, 3, 2, 2, 70.00, '2019-08-11 12:00:00.0000000', '2019-09-11 11:59:59.9999999'),
    ('RND132', 1, 3, 2, 2, 80.00, '2019-09-11 12:00:00.0000000', '2019-10-11 11:59:59.9999999'),
    ('RND132', 1, 3, 2, 2, 90.00, '2020-10-11 12:00:00.0000000', '2020-11-11 11:59:59.9999999'),

    ('NIE210', 2, 2, 1, 10, 139.0, '2018-08-11 12:00:00.0000000', '2018-09-11 11:59:59.9999999'),
    ('NIE210', 2, 2, 1, 10, 139.0, '2018-09-11 12:00:00.0000000', '2018-10-11 11:59:59.9999999'),
    ('NIE210', 2, 2, 1, 10, 139.0, '2020-10-11 12:00:00.0000000', '2020-11-11 11:59:59.9999999'),

    ('BIM239', 2, 2, 3, 9, 60.00, '2019-08-11 12:00:00.0000000', '2019-09-11 11:59:59.9999999'),
    ('BIM239', 2, 2, 3, 9, 70.00, '2019-09-11 12:00:00.0000000', '2019-10-11 11:59:59.9999999'),
    ('BIM239', 2, 2, 3, 9, 80.00, '2020-10-11 12:00:00.0000000', '2020-11-11 11:59:59.9999999'),

    ('YVY257', 2, 2, 5, 7, 50.00, '2019-09-11 12:00:00.0000000', '2019-10-11 11:59:59.9999999'),
    ('YVY257', 2, 2, 5, 7, 60.00, '2020-10-11 12:00:00.0000000', '2020-11-11 11:59:59.9999999'),

    ('QZS315', 3, 10, 1, 5, 110.00, '2019-09-11 12:00:00.0000000', '2019-10-11 11:59:59.9999999'),
    ('QZS315', 3, 10, 1, 5, 130.00, '2020-10-11 12:00:00.0000000', '2020-11-11 11:59:59.9999999'),

    ('HHC332', 3, 10, 3, 2, 70.00, '2019-09-11 12:00:00.0000000', '2019-10-11 11:59:59.9999999'),
    ('HHC332', 3, 10, 3, 2, 80.00, '2020-10-11 12:00:00.0000000', '2020-11-11 11:59:59.9999999'),

    ('EOM457', 4, 1, 4, 7, 50.00, '2019-10-11 12:00:00.0000000', '2019-11-11 11:59:59.9999999'),

    ('SGD512', 5, 8, 1, 2, 130.00, '2019-10-11 12:00:00.0000000', '2019-11-11 11:59:59.9999999'),

    ('LEJ535', 5, 8, 3, 5, 80.00, '2019-10-11 12:00:00.0000000', '2019-11-11 11:59:59.9999999');

DECLARE @MaxDate DATETIME2;
SET @MaxDate = '9999-12-31 23:59:59.9999999';

INSERT INTO BILET (KOD_BILETU, NR_LOTU, NR_SAMOLOTU, NR_MIEJSCA, NR_KLIENTA, CENA, SysStartTime, SysEndTime) 
VALUES
	('NZY114', 1, 3, 1, 4, 141.78, '2020-11-11 12:00:00.0000000', @MaxDate),
	('RND132', 1, 3, 2, 2, 92.16, '2020-11-11 12:00:00.0000000', @MaxDate),
	('YMD153', 1, 3, 4, 3, 70.89, '2020-11-11 12:00:00.0000000', @MaxDate),
	('NIE210', 2, 2, 1, 10, 139.0, '2020-11-11 12:00:00.0000000', @MaxDate),
	('BIM239', 2, 2, 3, 9, 90.35, '2020-11-11 12:00:00.0000000', @MaxDate),
	('YVY257', 2, 2, 5, 7, 69.5, '2020-11-11 12:00:00.0000000', @MaxDate),
	('QZS315', 3, 10, 1, 5, 144.36, '2020-11-11 12:00:00.0000000', @MaxDate),
	('HHC332', 3, 10, 3, 2, 93.83, '2020-11-11 12:00:00.0000000', @MaxDate),
	('IBP359', 3, 10, 5, 9, 72.18, '2020-11-11 12:00:00.0000000', @MaxDate),
	('PFW415', 4, 1, 1, 5, 121.02, '2020-11-11 12:00:00.0000000', @MaxDate),
	('HMF431', 4, 1, 3, 1, 78.66, '2020-11-11 12:00:00.0000000', @MaxDate),
	('EOM457', 4, 1, 4, 7, 60.51, '2020-11-11 12:00:00.0000000', @MaxDate),
	('SGD512', 5, 8, 1, 2, 142.76, '2020-11-11 12:00:00.0000000', @MaxDate),
	('LEJ535', 5, 8, 3, 5, 92.79, '2020-11-11 12:00:00.0000000', @MaxDate),
	('WTX553', 5, 8, 4, 3, 71.38, '2020-11-11 12:00:00.0000000', @MaxDate),
	('GOQ610', 6, 7, 1, 10, 160.18, '2020-11-11 12:00:00.0000000', @MaxDate),
	('GGR638', 6, 7, 3, 8, 104.12, '2020-11-11 12:00:00.0000000', @MaxDate),
	('WBP655', 6, 7, 5, 5, 80.09, '2020-11-11 12:00:00.0000000', @MaxDate),
	('WEZ715', 7, 3, 1, 5, 121.54, '2020-11-11 12:00:00.0000000', @MaxDate),
	('FHQ738', 7, 3, 3, 8, 79.0, '2020-11-11 12:00:00.0000000', @MaxDate),
	('KZD756', 7, 3, 5, 6, 60.77, '2020-11-11 12:00:00.0000000', @MaxDate),
	('IVV812', 8, 4, 1, 2, 159.82, '2020-11-11 12:00:00.0000000', @MaxDate),
	('DEX838', 8, 4, 3, 8, 103.88, '2020-11-11 12:00:00.0000000', @MaxDate),
	('GAL850', 8, 4, 4, 10, 79.91, '2020-11-11 12:00:00.0000000', @MaxDate),
	('IJE910', 9, 2, 1, 10, 136.18, '2020-11-11 12:00:00.0000000', @MaxDate),
	('QRS931', 9, 2, 3, 1, 88.52, '2020-11-11 12:00:00.0000000', @MaxDate),
	('UJG957', 9, 2, 5, 7, 68.09, '2020-11-11 12:00:00.0000000', @MaxDate),
	('DTE018', 10, 4, 1, 8, 167.04, '2020-11-11 12:00:00.0000000', @MaxDate),
	('EQC031', 10, 4, 3, 1, 108.58, '2020-11-11 12:00:00.0000000', @MaxDate),
	('YRA053', 10, 4, 5, 3, 83.52, '2020-11-11 12:00:00.0000000', @MaxDate);

ALTER TABLE bilet ADD PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);
ALTER TABLE bilet SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.biletHistory, DATA_CONSISTENCY_CHECK = ON));
GO
