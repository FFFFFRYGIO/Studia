USE lotniska_europy; 
GO

EXEC sp_settriggerorder
	@triggername = 'trg_urodziny',
	@order = 'FIRST',
	@stmttype = 'INSERT';

EXEC sp_settriggerorder
	@triggername = 'trg_powrot_klienta',
	@order = 'LAST',
	@stmttype = 'INSERT';

EXEC sp_settriggerorder
	@triggername = 'trg_licznik_lotow',
	@order = 'FIRST',
	@stmttype = 'INSERT';
