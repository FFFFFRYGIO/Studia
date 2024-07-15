select 'bilet' Tabela, count(*) liczba_wierszy
from bilet
union
select 'biletH' Tabela, count(*) liczba_wierszy
from biletHistory
union
select 'klient', count(*)
from klient
union
select 'klientH', count(*)
from klientHistory
union
select 'licencja', count(*)
from licencja
union
select 'lot', count(*)
from lot
union
select 'lotH', count(*)
from lotHistory
union
select 'lotnisko', count(*)
from lotnisko
union
select 'miejsce', count(*)
from miejsce
union
select 'model', count(*)
from model
union
select 'pracownik', count(*)
from pracownik
union
select 'rola_w_locie', count(*)
from rola_w_locie
union
select 'samolot', count(*)
from samolot
union
select 'znizka', count(*)
from znizka
