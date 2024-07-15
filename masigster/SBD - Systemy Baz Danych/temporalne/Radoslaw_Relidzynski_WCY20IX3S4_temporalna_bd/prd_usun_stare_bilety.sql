CREATE PROCEDURE prd_usun_stare_bilety
AS
BEGIN
    DELETE b
    FROM bilet b
    JOIN lot l ON b.nr_lotu = l.nr_lotu
    WHERE l.data_lotu < CAST(GETDATE() AS DATE);
END;
