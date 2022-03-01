.data
T: .space 1040
TB: .space 824
suma: .double 0

skladnik: .double 1330
ulamek: .double 0.35
numer: .double 10

stala: .double 3.2
liczT: .word 129
liczTB: .word 103
jeden: .double 1

.text
;pobieranie danych
ld f2, skladnik     ; stala skladnik
ld f4, ulamek       ; stala ulamek
ld f6, numer        ; stala numer
ld f12, jeden       ; liczba 1 typu double
ld f14, stala       ; stala do obliczen dla TB

;indeks i licznik dla T
lw r10, liczT       ; pobierz licznik T
addi r20, r0, T     ; indeks pierwszego elementu T

;pierwszy element T
addd f8, f2, f4     ; skladnik + ulamek
addd f10, f8, f6    ; skladnik + ulamek + numer
sd T(r0), f10       ; wpisz wynik do T[1]

;wypelnianie tabliy T
tablicaT:
addi r20, r20, #8   ; miejsce nastepnego elementu T (8 = sizeof(double))
addd f10, f10, f12  ; nastepna wartosc T
sd 0(r20), f10      ; wpisz do T[i]
subi r10, r10, #1   ; zmniejsz licznik
bnez r10, tablicaT   ; zakoncz, jesli licznik = 0

;indeks i licznik dla TB
lw r4, liczTB       ; pobierz licznik TB
addi r20, r20, #8   ; indeks pierwszego elementu TB (T[131] => TB[1])

;przygotowywanie zmiennych do obliczen dla TB
add r5, r0, r20     ; indeks nastepnej pamieci po T
subi r5, r5, #1040  ; indeks pierwszego elementu T
ld f16, 4096        ; wartosc T[i]
ld f18, 4120        ; wartosc T[i+3]
ld f20, 4136        ; wartosc T[i+5]
ld f22, 4144        ; wartosc T[i+6]
ld f24, 4152        ; wartosc T[i+7]
ld f28, 4160        ; wartosc T[i+8]

;wypenianie tablicy TB
tablicaTB:
;obliczanie licznika wartosci TB[i]
multd f26, f14, f16 ; iloczyn1 = stala * T[i]
multd f26, f26, f18 ; iloczyn1 *= T[i+3]
multd f26, f26, f20 ; iloczyn1 *= T[i+5]
multd f26, f26, f22 ; iloczyn1 *= T[i+6]
subd f26, f26, f24  ; iloczyn1 -= T[i+7]

;obliczanie mianownika wartosci TB[i]
subd f2, f2, f2     ; zerowanie rejestru do liczenia mianownika
multd f2, f20, f22  ; iloczyn2 = T[i+5] * T[i+6]
multd f2, f2, f24   ; iloczyn2 *= T[i+7]
addd f2, f2, f28   ; iloczyn2 += T[i+8]
addd f2, f2, f4     ; iloczyn2 += ulamek

;wartosc TB[i] = iloczyn1 / iloczyn2
divd f26, f26, f2

;dodawanie wartosci do TB[i]
sd 0(r20), f26      ; wpisz do TB[i]
addd f30, f30, f26  ; dodaj wartosc TB[i] do sumy
addi r20, r20, #8   ; nastepny indeks TB[i]

;nastepne wartosci do przeliczania
addd f16, f16, f12  ; nastepna wartosc T[i]
addd f18, f18, f12  ; nastepna wartosc T[i+3]
addd f20, f20, f12  ; nastepna wartosc T[i+5]
addd f22, f22, f12  ; nastepna wartosc T[i+6]
addd f24, f24, f12  ; nastepna wartosc T[i+7]
addd f28, f28, f12  ; nastepna wartosc T[i+8]

;zarzadzanie petla
subi r4, r4, #1     ; zmniejsz licznik
bnez r4, tablicaTB  ; zakoncz, jesli licznik = 0

;wpisywanie wyniku do zmiennej suma
sd 0(r20), f30      ; ostatnia zmiana indeksu (TB[104] => Suma) 





trap 0