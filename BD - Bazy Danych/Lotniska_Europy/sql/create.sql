CREATE TABLE bilet (
    kod_biletu  VARCHAR2(10) NOT NULL,
    cena        NUMBER NOT NULL,
    nr_miejsca  NUMBER NOT NULL,
    nr_lotu     NUMBER NOT NULL,
    nr_samolotu NUMBER NOT NULL,
    nr_klienta  NUMBER NOT NULL
);

ALTER TABLE bilet ADD CONSTRAINT bilet_pk PRIMARY KEY ( kod_biletu );

CREATE TABLE klient (
    nr_klienta     NUMBER NOT NULL,
    imie           VARCHAR2(20) NOT NULL,
    nazwisko       VARCHAR2(20) NOT NULL,
    data_urodzenia DATE,
    plec           VARCHAR2(1) NOT NULL,
    rodzaj_znizki  VARCHAR2(20)
);

ALTER TABLE klient ADD CONSTRAINT klient_pk PRIMARY KEY ( nr_klienta );

CREATE TABLE licencja (
    nr_pracownika NUMBER NOT NULL,
    nr_modelu     NUMBER NOT NULL
);

ALTER TABLE licencja ADD CONSTRAINT licencja_pk PRIMARY KEY ( nr_pracownika,
                                                              nr_modelu );

CREATE TABLE lot (
    nr_lotu           NUMBER NOT NULL,
    data_lotu         DATE NOT NULL,
    czas_lotu_min     NUMBER NOT NULL,
    lotnisko_startowe NUMBER NOT NULL,
    lotnisko_docelowe NUMBER NOT NULL,
    nr_samolotu       NUMBER NOT NULL
);

ALTER TABLE lot ADD CONSTRAINT lot_pk PRIMARY KEY ( nr_lotu );

CREATE TABLE lotnisko (
    nr_lotniska    NUMBER NOT NULL,
    nazwa          VARCHAR2(40) NOT NULL,
    kraj_polozenia VARCHAR2(20) NOT NULL
);

ALTER TABLE lotnisko ADD CONSTRAINT lotnisko_pk PRIMARY KEY ( nr_lotniska );

CREATE TABLE miejsce (
    nr_miejsca  NUMBER NOT NULL,
    klasa       VARCHAR2(20) NOT NULL,
    nr_samolotu NUMBER NOT NULL
);

ALTER TABLE miejsce ADD CONSTRAINT miejsce_pk PRIMARY KEY ( nr_miejsca,
                                                            nr_samolotu );

CREATE TABLE model (
    nr_modelu NUMBER NOT NULL,
    nazwa     VARCHAR2(40) NOT NULL
);

ALTER TABLE model ADD CONSTRAINT model_pk PRIMARY KEY ( nr_modelu );

CREATE TABLE pracownik (
    nr_pracownika  NUMBER NOT NULL,
    imie           VARCHAR2(20) NOT NULL,
    nazwisko       VARCHAR2(20) NOT NULL,
    data_urodzenia DATE NOT NULL
);

ALTER TABLE pracownik ADD CONSTRAINT pracownik_pk PRIMARY KEY ( nr_pracownika );

CREATE TABLE rola_w_locie (
    nr_pracownika NUMBER NOT NULL,
    nr_lotu       NUMBER NOT NULL,
    rola          VARCHAR2(10) NOT NULL
);

ALTER TABLE rola_w_locie ADD CONSTRAINT rola_w_locie_pk PRIMARY KEY ( nr_pracownika,
                                                                      nr_lotu );

CREATE TABLE samolot (
    nr_samolotu   NUMBER NOT NULL,
    rok_produkcji NUMBER NOT NULL,
    nr_modelu     NUMBER NOT NULL
);

ALTER TABLE samolot ADD CONSTRAINT samolot_pk PRIMARY KEY ( nr_samolotu );

CREATE TABLE znizka (
    rodzaj_znizki   VARCHAR2(20) NOT NULL,
    procent_umazany NUMBER NOT NULL
);

ALTER TABLE znizka ADD CONSTRAINT znizka_pk PRIMARY KEY ( rodzaj_znizki );

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
