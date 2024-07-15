-- TEST trg_powrot_klienta
INSERT INTO KLIENT (IMIE, NAZWISKO, DATA_URODZENIA, RODZAJ_ZNIZKI, PLEC) 
VALUES ('Karol', 'Karolewski', CAST('03-08-2002' AS DATETIME), NULL, 'M');

-- pobierz nr_klienta nowo dodanego klienta
DECLARE @nr_klienta INT;
SELECT @nr_klienta = nr_klienta
FROM KLIENT
WHERE IMIE = 'Karol' AND NAZWISKO = 'Karolewski' AND DATA_URODZENIA = CAST('03-08-2002' AS DATETIME);

-- usun klienta
DELETE FROM KLIENT 
WHERE nr_klienta = @nr_klienta;

-- dodaj ponownie klienta z nowymi danymi
INSERT INTO KLIENT (IMIE, NAZWISKO, DATA_URODZENIA, RODZAJ_ZNIZKI, PLEC) 
VALUES ('Karol', 'Karolewski', CAST('03-08-2002' AS DATETIME), NULL, 'M');