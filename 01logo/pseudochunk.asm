	device zxspectrum128
	org #6000
SnaStart:
	ei
	ld a,7
	out (#fe),a
	call putlogo
ZaLoop:
	call logoshow
	jr ZaLoop

logoshow:
	halt
	call logotip
	jr nc,logoshow
	call logotip_change
	ld b,0
.l1 halt
	djnz .l1
	ret

putlogo
	ld hl,#5800
	ld de,#5801
	ld bc,#300
	ld (hl),%00111111
	ldir
	ld hl,#5900
	ld de,lg_data
	ld b,4*7
.l1
	ld a,(de)
	push de
	ld d,%00111111
	ld e,%00111000
	ld c,8
.l2	rlca
	jr nc,.l3
	ld (hl),e
	jr .l4
.l3 ld (hl),d
.l4	inc hl
	dec c
	jr nz,.l2
	pop de
	inc de
	djnz .l1
	ret

lg_data
	db %00000000,%10000000,%00000000,%00000000
	db %11111000,%11111011,%11101111,%10111110
	db %10001000,%10001010,%00101000,%10100010
	db %10001010,%10001010,%00101000,%10111110
	db %10001000,%10001010,%00101000,%10100000
	db %11111000,%11111011,%11101000,%10111110
	db %00001000,%00000000,%00000000,%00000000

logotip
	ld l,0
	ld h,#40 ;
	ld a,(hl)
	scf
.l2	nop
	rla
	ld de,#20
	ld b,192 ;#40
.l0 ld (hl),a
	add hl,de
	djnz .l0
.l1	ld a,0
	inc a
	and 7
	ld (.l1+1),a ;C - dropped
	ret nz
	ld a,(logotip+1)
	inc a
	and #1f ;C - dropped
	ld (logotip+1),a
	ret NZ
	scf ;C - SETTED
	ret
logotip_change
	ld a,(logotip.l2)
	xor #3f
	ld (logotip.l2),a
	ret

	savesna "pseudochunk.sna",SnaStart
	labelslist "label.lbl"