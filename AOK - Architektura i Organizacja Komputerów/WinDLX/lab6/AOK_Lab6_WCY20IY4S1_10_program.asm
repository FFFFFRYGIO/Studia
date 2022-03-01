.data
k: .word 0
nr: .word 10
rozmiar: .word 10
wektor: .word 110, 120, 130, 140, 150, 160, 170, 180, 190, 200
;z2
suma1: .word 0
;z3
stala: .word 0
;z5
suma2: .word 0
;z6
roznica: .word 0
;z7
iloczyn: .word 0

.text
; z2: licze sume liczb w wektorze
	lw r1, rozmiar		;pobierz rozmiar (licznik)
	addi r2, r0, wektor	;r2 wskazuje na pierwszy element wektora
	loop1:
		lw r3, 0(r2) 	 ;wczytaj liczbe
		add r10, r10, r3 ;dodaj liczbe
		addi r2, r2, #4  ;wskaz nastepna liczbe - sizeof(word)=4
		subi r1, r1, #1  ;zmniejsz licznik
		bnez r1, loop1	 ;zakoncz jesli licznik = 0
	sw suma1, r10		;wpisz do "suma1"

; z3: licze stala ((k+1)*nr)
	lw r1, k	;pobierz k
	lw r2, nr	;pobierz nr
	addi r1, r1, #1 ;k => k+1
	mult r3, r1, r2 ; (K+1)*nr
	sw stala, r3	;wpisz do "stala"

; z4: zwiekszam wartosci w tablicy
	lw r1, rozmiar		;pobierz rozmiar (licznik)
	addi r2, r0, wektor	;r2 wskazuje na pierwszy element wektora
	loop2:
		lw r4, 0(r2)	 ;wczytaj liczbe
		add r5, r4, r3	 ;r5 => liczba + stala
		sw 0(r2), r5	 ;wpisanie liczby
		addi r2, r2, #4  ;wskaz nastepna liczbe - sizeof(word)=4
		subi r1, r1, #1  ;zmniejsz licznik
		bnez r1, loop2	 ;zakoncz jesli licznik = 0

; z5: licze druga sume liczb w nowym wektorze
    lw r1, rozmiar      ;pobierz rozmiar
	addi r2, r0, wektor	;r2 wskazuje na pierwszy element wektora
    lw r10, suma2        ;zeruj rejestr r10
	loop3:
		lw r3, 0(r2) 	 ;wczytaj liczbe
		add r10, r10, r3 ;dodaj liczbe
		addi r2, r2, #4  ;wskaz nastepna liczbe - sizeof(word)=4
		subi r1, r1, #1  ;zmniejsz licznik
		bnez r1, loop3	 ;zakoncz jesli licznik = 0
	sw suma2, r10		;wpisz do "suma2"

; z6: licze roznice
    lw r1, suma1    ;pobierz suma1
    lw r2, suma2    ;pobierz suma2
    sub r10, r2, r1 ;oblicz roznice
    sw roznica, r10 ;wpisz do "roznica"

; z7: licze iloczyn
    lw r1, rozmiar    ;pobierz rozmiar
    lw r2, stala    ;pobierz stala
    mult r10, r2, r1 ;oblicz iloczyn
    sw iloczyn, r10 ;wpisz do "iloczyn"

trap 0