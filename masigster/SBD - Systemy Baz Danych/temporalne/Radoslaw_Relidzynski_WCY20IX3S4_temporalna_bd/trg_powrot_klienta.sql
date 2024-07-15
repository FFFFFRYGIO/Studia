-- jesli klient znajduje si? w tabeli historycznej, u?yj starego nr_klienta
CREATE TRIGGER trg_powrot_klienta
ON klient
AFTER INSERT
AS
BEGIN
    DECLARE @Message NVARCHAR(1000);

    DECLARE @nr_klienta INT;
    DECLARE @imie NVARCHAR(50);
    DECLARE @nazwisko NVARCHAR(50);
    DECLARE @data_urodzenia DATE;
    DECLARE @plec NVARCHAR(1);
	DECLARE @rodzaj_znizki NVARCHAR(20);

    DECLARE client_comeback_cursor CURSOR FOR
    SELECT imie, nazwisko, data_urodzenia, plec, rodzaj_znizki
    FROM inserted;

    OPEN client_comeback_cursor;
    FETCH NEXT FROM client_comeback_cursor INTO @imie, @nazwisko, @data_urodzenia, @plec, @rodzaj_znizki;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @nr_klienta = nr_klienta
        FROM klientHistory
        WHERE imie = @imie AND nazwisko = @nazwisko AND data_urodzenia = @data_urodzenia;

        IF @nr_klienta IS NOT NULL
        BEGIN
            DELETE FROM klient
            WHERE imie = @imie AND nazwisko = @nazwisko AND data_urodzenia = @data_urodzenia;
			
			SET IDENTITY_INSERT klient ON;

            INSERT INTO klient (nr_klienta, imie, nazwisko, data_urodzenia, plec, rodzaj_znizki)
            VALUES (@nr_klienta, @imie, @nazwisko, @data_urodzenia, @plec, @rodzaj_znizki);

            SET @Message = FORMATMESSAGE('Klient %s %s istnieje w historii, uzyto starego nr_klienta %d.', @imie, @nazwisko, @nr_klienta);
            RAISERROR(@Message, 0, 1) WITH NOWAIT;
        END
        ELSE
        BEGIN
            SET @Message = FORMATMESSAGE('Klient %s %s zostal dodany jako nowy klient.', @imie, @nazwisko);
            RAISERROR(@Message, 0, 1) WITH NOWAIT;
        END

        FETCH NEXT FROM client_comeback_cursor INTO @imie, @nazwisko, @data_urodzenia, @plec, @rodzaj_znizki;
    END;

    CLOSE client_comeback_cursor;
    DEALLOCATE client_comeback_cursor;

END;
GO
