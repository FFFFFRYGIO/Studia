.data
TA: .space 440
TB: .space 400
Suma: .double 0
licznik: .word 109
licznik2: .word 100
mnoznik: .word 200

.text
lw r1, licznik		; pobierz licznik
addi r2, r0, #1010	; podaj pierwsza wartosc
sw TA(r0), r2		; wpisz pierwsza wartosc do TA
addi r3, r0, TA     ; Indeks pierwszego elementu TA

tablicaA:
addi r3, r3, #4     ; Nastepny indeks
addi r2, r2, #1     ; Nastepna wartosc
sw 0(r3), r2		; wpisz do indeksu dana wartosc
subi r1, r1, #1		; zmniejsz licznik
bnez r1, tablicaA	; zakoncz, jesli licznik = 0 

lw r4, licznik2		; pobierz licznik2
lw r5, mnoznik		; pobierz mnoznik
sw TB(r0), r11		; pobierz indeks 1 elementu TB
lw r7, 4104         ; indeks TA[2]
lw r8, 4116         ; indeks TA[5]

tablicaB:
add r9, r7, r8      ; r9 = TA[i+2] + TA[i+5]
addi r3, r3, #4     ; nastepny indeks (TA[110] -> TB[0])
mult r11, r9, r5	; r11 = (TA[i+2] + TA[i+5]) * 200
add r10, r10, r11	; dodaj wartosc do sumy
sw 0(r3), r11		; wpisz do indeksu wartosc
addi r7, r7, #1		; nastepny indeks TA[i+2]
addi r8, r8, #1     ; nastepny indeks TA[i+5]
subi r4, r4, #1		; zmniejsz licznik2
bnez r4, tablicaB	; zakoncz, jesli licznik2 = 0 

movi2fp F4, R10		; pobierz jako float sume
cvti2d F4, F4		; skonwertuj jako double
sd Suma, F4         ; wpisz do zmiennej Suma

trap 0