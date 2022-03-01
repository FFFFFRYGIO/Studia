--KOSZTY BILETÓW DLA PIERWSZEJ KLASY
create or replace view koszty_biletow (bilet, koszt)
as
    select b.kod_biletu bilet, round(b.cena*(1-nvl(z.procent_umazany,0)/100),2) koszt from bilet b
    join klient k on k.nr_klienta = b.nr_klienta
    left join znizka z on z.rodzaj_znizki = k.rodzaj_znizki
    join miejsce m on m.nr_miejsca = b.nr_miejsca and m.nr_samolotu = b.nr_samolotu
    order by koszt
;
--NAJWIĘKSZA ILOŚĆ LOTÓW JEDNEGO PILOTA
CREATE OR REPLACE VIEW najwiecej_lotow (najwiecej)
as
    select max(count(*)) najwiecej
    from pracownik p
    join rola_w_locie r on r.nr_pracownika = p.nr_pracownika and r.rola = 'pilot'
    join lot l on l.nr_lotu = r.nr_lotu
    group by p.nr_pracownika
;
--PILOCI O NAJWIEKSZEJ ILOSCI LOTOW
CREATE OR REPLACE VIEW najczestsi_piloci (pilot)
as
    select p.imie||' '||p.nazwisko pilot
    from pracownik p
    where p.nr_pracownika in (
        select p.nr_pracownika
        from pracownik p
        join rola_w_locie r on r.nr_pracownika = p.nr_pracownika and r.rola = 'pilot'
        group by p.nr_pracownika
        having count(*) = (select najwiecej from najwiecej_lotow)
    )
;
--KLIENCI, KTÓRZY WYGRALI KONKURS
CREATE OR REPLACE VIEW zwyciezcy_konkursu (zwyciezca)
as
    select distinct k.imie||' '||k.nazwisko zwyciezca
    from klient k
    join bilet b on b.nr_klienta = k.nr_klienta
    join miejsce m on m.nr_samolotu = b.nr_samolotu and m.nr_miejsca = b.nr_miejsca
    join samolot s on s.nr_samolotu = m.nr_samolotu
    join model x on x.nr_modelu = s.nr_modelu and x.nazwa like '%Boeing%'
    where mod(extract(year from k.data_urodzenia),5) = m.nr_miejsca
;
--SAMOLOTY O NAJWIĘKSZYM ZYSKU
CREATE OR REPLACE VIEW najwiekszy_zysk (samolot, zysk)
as
    select 'nr.'||s.nr_samolotu||': '||m.nazwa samolot, sum(k.koszt) zysk
    from samolot s
    join model m on s.nr_modelu = m.nr_modelu
    join lot l on l.nr_samolotu = s.nr_samolotu
    join bilet b on b.nr_lotu = l.nr_lotu
    join koszty_biletow k on b.kod_biletu = k.bilet
    group by s.nr_samolotu, m.nazwa
    order by sum(k.koszt) desc
    fetch next 3 rows only
;