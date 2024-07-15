-- TEST trg_licznik_lotow
INSERT INTO lot (data_lotu, czas_lotu_min, lotnisko_startowe, lotnisko_docelowe, nr_samolotu)
VALUES (DATEADD(MONTH, 1, CONVERT(DATE, GETDATE())), 120, 1, 2, 1);

-- pobierz nr_lotu nowo dodanego lotu
DECLARE @nr_lotu INT;
SELECT @nr_lotu = nr_lotu
FROM lot
WHERE data_lotu = DATEADD(MONTH, 1, CONVERT(DATE, GETDATE())) AND nr_samolotu = 1;

UPDATE lot
SET czas_lotu_min = 130
WHERE nr_lotu = @nr_lotu;

UPDATE lot
SET czas_lotu_min = 140
WHERE nr_lotu = @nr_lotu;

UPDATE lot
SET czas_lotu_min = 150
WHERE nr_lotu = @nr_lotu;

DELETE FROM lot
WHERE data_lotu = DATEADD(MONTH, 1, CONVERT(DATE, GETDATE())) AND nr_samolotu = 1;
