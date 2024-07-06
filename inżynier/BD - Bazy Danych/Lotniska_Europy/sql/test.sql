--testowanie lotów
select l.nr_lotu bledne_loty
    from lot l
where l.lotnisko_startowe = l.lotnisko_docelowe
or l.czas_lotu_min <= 0
;
--testowanie pilotów
with tmp as (
select l.nr_lotu dobre_loty
    from lot l
join samolot s on s.nr_samolotu = l.nr_samolotu
join rola_w_locie r on r.nr_lotu = l.nr_lotu
join pracownik p on p.nr_pracownika = r.nr_pracownika
join licencja x on x.nr_pracownika = p.nr_pracownika
join model m on m.nr_modelu = x.nr_modelu 
    and m.nr_modelu = s.nr_modelu
order by l.nr_lotu
)
select l.nr_lotu bledne_loty
    from lot l
where l.nr_lotu not in (select tmp.dobre_loty from tmp)
;
--testowanie samolotów
select b.kod_biletu bilet, b.nr_samolotu samolot_bilet, l.nr_samolotu samolot_lot
    from bilet b
join miejsce m on b.nr_samolotu = m.nr_samolotu
join lot l on l.nr_lotu = b.nr_lotu and l.nr_samolotu <> b.nr_samolotu
;