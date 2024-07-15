CREATE DATABASE lotniska_europy;

GO

USE lotniska_europy;

CREATE TABLE bilet (
    kod_biletu  VARCHAR(10) PRIMARY KEY NOT NULL,
    cena        INT NOT NULL CHECK (cena >= 0),
    nr_miejsca  INT NOT NULL,
    nr_lotu     INT NOT NULL,
    nr_samolotu INT NOT NULL,
    nr_klienta  INT NOT NULL,
	SysStartTime   DATETIME2 GENERATED ALWAYS AS ROW START,
    SysEndTime     DATETIME2 GENERATED ALWAYS AS ROW END,
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.biletHistory));
GO

CREATE TABLE klient (
    nr_klienta     INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    imie           VARCHAR(20) NOT NULL,
    nazwisko       VARCHAR(20) NOT NULL,
    data_urodzenia DATE CHECK (data_urodzenia <= CAST(GETDATE() AS DATE)),
    plec           VARCHAR(1) NOT NULL,
    rodzaj_znizki  VARCHAR(20),
	SysStartTime   DATETIME2 GENERATED ALWAYS AS ROW START,
    SysEndTime     DATETIME2 GENERATED ALWAYS AS ROW END,
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.klientHistory));
GO

CREATE TABLE licencja (
    nr_pracownika INT NOT NULL,
    nr_modelu     INT NOT NULL
);

ALTER TABLE licencja ADD CONSTRAINT licencja_pk PRIMARY KEY ( nr_pracownika,
                                                              nr_modelu );

CREATE TABLE lot (
    nr_lotu           INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    data_lotu         DATE NOT NULL CHECK (data_lotu >= CAST(GETDATE() AS DATE)),
    czas_lotu_min     INT NOT NULL CHECK (czas_lotu_min > 0),
    lotnisko_startowe INT NOT NULL,
    lotnisko_docelowe INT NOT NULL,
    nr_samolotu       INT NOT NULL,
	SysStartTime   DATETIME2 GENERATED ALWAYS AS ROW START,
    SysEndTime     DATETIME2 GENERATED ALWAYS AS ROW END,
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.lotHistory));
GO

CREATE TABLE lotnisko (
    nr_lotniska    INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    nazwa          VARCHAR(40) NOT NULL,
    kraj_polozenia VARCHAR(20) NOT NULL
);

CREATE TABLE miejsce (
    nr_miejsca  INT NOT NULL,
    klasa       VARCHAR(20) NOT NULL,
    nr_samolotu INT NOT NULL
);

ALTER TABLE miejsce ADD CONSTRAINT miejsce_pk PRIMARY KEY ( nr_miejsca,
                                                            nr_samolotu );

CREATE TABLE model (
    nr_modelu INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    nazwa     VARCHAR(40) NOT NULL
);

CREATE TABLE pracownik (
    nr_pracownika  INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    imie           VARCHAR(20) NOT NULL,
    nazwisko       VARCHAR(20) NOT NULL,
    data_urodzenia DATE NOT NULL CHECK (data_urodzenia <= CAST(GETDATE() AS DATE))
);

CREATE TABLE rola_w_locie (
    nr_pracownika INT NOT NULL,
    nr_lotu       INT NOT NULL,
    rola          VARCHAR(10) NOT NULL
);

ALTER TABLE rola_w_locie ADD CONSTRAINT rola_w_locie_pk PRIMARY KEY ( nr_pracownika,
                                                                      nr_lotu );

CREATE TABLE samolot (
    nr_samolotu   INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    rok_produkcji INT NOT NULL,
    nr_modelu     INT NOT NULL
);

CREATE TABLE znizka (
    rodzaj_znizki   VARCHAR(20) PRIMARY KEY NOT NULL,
    procent_umazany INT NOT NULL CHECK (procent_umazany >= 0)
);

ALTER TABLE bilet
    ADD CONSTRAINT bilet_klient_fk FOREIGN KEY ( nr_klienta )
        REFERENCES klient ( nr_klienta );

ALTER TABLE bilet
    ADD CONSTRAINT bilet_lot_fk FOREIGN KEY ( nr_lotu )
        REFERENCES lot ( nr_lotu );

ALTER TABLE bilet
    ADD CONSTRAINT bilet_miejsce_fk FOREIGN KEY ( nr_miejsca,
                                                  nr_samolotu )
        REFERENCES miejsce ( nr_miejsca,
                             nr_samolotu );

ALTER TABLE klient
    ADD CONSTRAINT klient_znizka_fk FOREIGN KEY ( rodzaj_znizki )
        REFERENCES znizka ( rodzaj_znizki );

ALTER TABLE licencja
    ADD CONSTRAINT licencja_model_fk FOREIGN KEY ( nr_modelu )
        REFERENCES model ( nr_modelu );

ALTER TABLE licencja
    ADD CONSTRAINT licencja_pracownik_fk FOREIGN KEY ( nr_pracownika )
        REFERENCES pracownik ( nr_pracownika );

ALTER TABLE lot
    ADD CONSTRAINT lot_lotnisko_fk FOREIGN KEY ( lotnisko_startowe )
        REFERENCES lotnisko ( nr_lotniska );

ALTER TABLE lot
    ADD CONSTRAINT lot_lotnisko_fkv2 FOREIGN KEY ( lotnisko_docelowe )
        REFERENCES lotnisko ( nr_lotniska );

ALTER TABLE lot
    ADD CONSTRAINT lot_samolot_fk FOREIGN KEY ( nr_samolotu )
        REFERENCES samolot ( nr_samolotu );

ALTER TABLE miejsce
    ADD CONSTRAINT miejsce_samolot_fk FOREIGN KEY ( nr_samolotu )
        REFERENCES samolot ( nr_samolotu );

ALTER TABLE rola_w_locie
    ADD CONSTRAINT rola_w_locie_lot_fk FOREIGN KEY ( nr_lotu )
        REFERENCES lot ( nr_lotu );

ALTER TABLE rola_w_locie
    ADD CONSTRAINT rola_w_locie_pracownik_fk FOREIGN KEY ( nr_pracownika )
        REFERENCES pracownik ( nr_pracownika );

ALTER TABLE samolot
    ADD CONSTRAINT samolot_model_fk FOREIGN KEY ( nr_modelu )
        REFERENCES model ( nr_modelu );
