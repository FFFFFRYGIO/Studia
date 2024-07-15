-- jesli klient zalozy konto w dniu urodzin, to dostanie znizke
CREATE TRIGGER trg_urodziny
ON klient
AFTER INSERT
AS
BEGIN
    DECLARE @Message NVARCHAR(1000);

	DECLARE @nr_klienta INT;
	DECLARE @imie NVARCHAR(50);
    DECLARE @nazwisko NVARCHAR(50);
	-- DECLARE @data_dodania DATE;
	DECLARE @data_urodzenia DATE;
	DECLARE @plec NVARCHAR(1);
	DECLARE @rodzaj_znizki NVARCHAR(20);

    DECLARE @miesiac_dodania INT;
    DECLARE @dzien_dodania INT;
    DECLARE @miesiac_urodzenia INT;
    DECLARE @dzien_urodzenia INT;
	DECLARE @klient NVARCHAR(40);

	DECLARE client_birthday_cursor CURSOR FOR
    SELECT imie, nazwisko, data_urodzenia
    FROM inserted;

	OPEN client_birthday_cursor;
    FETCH NEXT FROM client_birthday_cursor INTO @imie, @nazwisko, @data_urodzenia;

	WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @miesiac_dodania = MONTH(GETDATE());
        SET @dzien_dodania = DAY(GETDATE());
        SET @miesiac_urodzenia = MONTH(@data_urodzenia);
        SET @dzien_urodzenia = DAY(@data_urodzenia);
		SET @klient = CONCAT(@imie, ' ', @nazwisko);

        IF @miesiac_dodania = @miesiac_urodzenia AND @dzien_dodania = @dzien_urodzenia
        BEGIN
            SET @Message = FORMATMESSAGE('%s zalozyl wlasnie konto w dniu urodzin, przeslij mu znizki', @klient);
            RAISERROR(@Message, 0, 1) WITH NOWAIT;
        END

        FETCH NEXT FROM client_birthday_cursor INTO @imie, @nazwisko, @data_urodzenia;
    END;

	CLOSE client_birthday_cursor;
    DEALLOCATE client_birthday_cursor;

END;
GO
