	device zxspectrum128
	org #6000
SnaStart:
	ei
ZaLoop:
	ld hl,#5800
	ld ix,#0b00
.l1	ld b,xh
.l0	ld (hl),%00101010
	ld a,xl
	ld de,#0001
	and %00000011
	jr z,.smena
	ld de,#0020
	dec a
	jr z,.smena
	ld de,#ffff
	dec a
	jr z,.smena
	ld de,#ffe0
.smena
	add hl,de
	djnz .l0
	inc xl
	ld a,xl
	cp 3
	jr c,.l1
	bit 0,a
	jr z,.l1
	dec xh
	jr nz,.l1
	jr $

	display $-SnaStart

	savesna "pseudochunk.sna",SnaStart
	labelslist "label.lbl"