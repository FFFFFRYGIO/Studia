-- nie mozna edytowa? informacji o locie, który istnieje juz od miesiaca
CREATE TRIGGER trg_licznik_lotow
ON lot
AFTER UPDATE
AS
BEGIN
	DECLARE @Message NVARCHAR(1000);

    DECLARE @nr_lotu INT;
    DECLARE @licznik INT;

    SELECT @nr_lotu = INSERTED.nr_lotu
    FROM INSERTED;

    SELECT @licznik = COUNT(*)
    FROM dbo.lotHistory
    WHERE nr_lotu = @nr_lotu;

	SET @Message = FORMATMESSAGE('To jest %s zmiana lotu numer  %s ', CAST(@licznik AS VARCHAR), CAST(@nr_lotu AS VARCHAR));
	RAISERROR(@Message, 0, 1) WITH NOWAIT;

END;
GO
