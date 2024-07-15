-- suma cen biletów zakupionych w ramach różnych rodzajów zniżek przez klientów w 2023 roku licząc tylko te o sumie większej niż 500
SELECT k.rodzaj_znizki, SUM(b.cena) AS suma_cen_biletow
FROM bilet FOR SYSTEM_TIME BETWEEN '2023-01-01' AND '2024-01-01' b
JOIN klient k ON b.nr_klienta = k.nr_klienta
GROUP BY k.rodzaj_znizki
HAVING SUM(b.cena) > 500
ORDER BY suma_cen_biletow DESC;

-- wiek informacji o locie
SELECT l.nr_lotu, MIN(l.SysStartTime) AS data_dodania, DATEDIFF(DAY, MIN(l.SysStartTime), GETDATE()) AS wiek_w_dniach
FROM lot FOR SYSTEM_TIME ALL l
GROUP BY l.nr_lotu;

-- średni czas dla lotu na podstawie wszystkich wartości historycznych
SELECT l.nr_lotu, AVG(l.czas_lotu_min) AS sredni_czas_lotu
FROM lot FOR SYSTEM_TIME ALL l
GROUP BY l.nr_lotu
ORDER BY sredni_czas_lotu DESC;

-- zliczanie zmian w biletach w 2020 roku w zależności od lotu
SELECT b.nr_lotu, COUNT(*) AS liczba_zmian
FROM bilet FOR SYSTEM_TIME BETWEEN '2020-01-01' AND '2020-12-31' b
WHERE b.SysEndTime != '9999-12-31 23:59:59.9999999'
GROUP BY b.nr_lotu
ORDER BY liczba_zmian DESC;

-- zliczanie biletów kupionych przez klienta w zależności od roku
SELECT k.nr_klienta, CONCAT(k.imie, ' ', k.nazwisko) AS klient, YEAR(b.SysStartTime) AS Rok, COUNT(DISTINCT b.kod_biletu) AS liczba_biletow
FROM bilet FOR SYSTEM_TIME ALL b
JOIN klient k ON b.nr_klienta = k.nr_klienta
GROUP BY k.nr_klienta, k.imie, k.nazwisko, YEAR(b.SysStartTime)
ORDER BY k.nr_klienta, Rok;

-- średnia cen biletów uwzględniając wszystkie aktualizacje w zależności od modelu samolotu realizującego lot
SELECT m.nazwa AS ModelSamolotu, AVG(b.cena) AS srednia_cen_biletow
FROM bilet FOR SYSTEM_TIME ALL b
JOIN lot l ON b.nr_lotu = l.nr_lotu
JOIN samolot s ON l.nr_samolotu = s.nr_samolotu
JOIN model m ON s.nr_modelu = m.nr_modelu
GROUP BY m.nazwa
ORDER BY srednia_cen_biletow DESC;

-- średnia cena biletów dla klienta w zależności od zniżki jaką ma lub miał
WITH ZmianyZnizek AS (
    SELECT k.nr_klienta, CONCAT(k.imie, ' ', k.nazwisko) AS klient, k.rodzaj_znizki, k.SysStartTime, k.SysEndTime
    FROM klient FOR SYSTEM_TIME BETWEEN '2021-01-01' AND '2023-01-01' k
),
BiletyCeny AS (
    SELECT b.nr_klienta, b.cena, b.SysStartTime
    FROM bilet FOR SYSTEM_TIME BETWEEN '2021-01-01' AND '2023-01-01' b
)
SELECT zz.klient klient, zz.rodzaj_znizki, AVG(bc.cena) AS srednia_cen_biletow
FROM ZmianyZnizek zz
JOIN BiletyCeny bc ON zz.nr_klienta = bc.nr_klienta
GROUP BY zz.klient, zz.rodzaj_znizki
ORDER BY klient, rodzaj_znizki DESC;

-- średnia cena biletu na podstawie klas miejsc
SELECT m.klasa, AVG(b.cena) AS srednia_cena
FROM bilet FOR SYSTEM_TIME AS OF '2021-01-01 12:00:00.0000000' b
JOIN miejsce m ON b.nr_miejsca = m.nr_miejsca AND b.nr_samolotu = m.nr_samolotu
GROUP BY m.klasa
ORDER BY srednia_cena DESC;
