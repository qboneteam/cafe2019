	device zxspectrum128
	org #6000
SnaStart:
	ei
ZaLoop:
	xor	a
	out	(#fe),a
  ld  bc,600
;w1  dec  bc
;    ld  a,b
;      or  c
;        jp  nz,w1
	halt
	ld a,1
	out	(#fe),a
	call spiralka
	jr ZaLoop

;tabl_2x2_spiral
ulitkalen = 16
len = 144
spiralka:
current:
	ld a,0
	cp ulitkalen
	jr nc,.label0
	ld (shift+1),a
	inc a
	ld (count+1),a
	xor a
	ld (mask_shift+1),a
	jp spiralkorisovalko
.label0
	cp len ;-1
	jr c,.label1
;	jr $

	ld b,a
	ld a,len+ulitkalen-2
	sub b
	ld b,a
	inc a ;!!!!!!
	ld (count+1),a
	ld a,len
	sub b
	dec a ;!!!
	ld (mask_shift+1),a
	ld a,len-1
	ld (shift+1),a
	jp spiralkorisovalko

.label1
	ld (shift+1),a
	ld a,16
	ld (count+1),a
	xor a
	ld (mask_shift+1),a
;	jp spiralkorisovalko
spiralkorisovalko
shift:
	ld a,0
	ld l,a
	ld h,0
	add hl,hl
	ld de,tabl_2x2_spiral
	add hl,de

mask_shift
	ld a,0
	add a
	ld e,a
	ld d,high mask

count
	ld b,0
.l0 push hl
	ld a,(hl)
	inc hl
	ld h,(hl)
	add 4
	ld l,a

	ld a,(de)
	add h
	ld h,a
	inc e
	ld a,(de)
	xor (hl)
	inc e

	ld c,a

	push hl

	ld a,c
	ld (hl),a:inc l:ld (hl),a
	ld a,#20:add l:ld l,a
	ld a,c
	ld (hl),a:dec l:ld (hl),a

	pop hl
	ld a,4
	add h
	ld h,a

	ld a,c
	ld (hl),a:inc l:ld (hl),a
	ld a,#20:add l:ld l,a
	ld a,c
	ld (hl),a:dec l:ld (hl),a

	pop hl
	dec hl
	dec hl
	djnz .l0
	ld a,(current+1)
	inc a
	ld (current+1),a
	cp len + ulitkalen - 1
	ret nz
	xor a
	ld (current+1),a
	ret
	display $-current

	align #100
table_mas


mask:
	db	0,%00010001
	db	2,%01000100
	db	0,%01000100
	db	2,%00010001

	db	1,%00100010
	db	3,%10001000
	db	1,%10001000
	db	3,%00100010

	db	0,%00100010
	db	2,%10001000
	db	0,%10001000
	db	2,%00100010

	db	1,%00010001
	db	3,%01000100
	db	1,%01000100
	db	3,%00010001


	align #100
tabl_4x4_spiral
	dw #4000,#4004,#4008,#400c,#4010,#4014
	dw #4094,#4814,#4894,#5014,#5094,#5090
	dw #508c,#5088,#5084,#5080,#5000,#4880
	dw #4800,#4080,#4084,#4088,#408c,#4090
	dw #4810,#4890,#5010,#500c,#5008,#5004
	dw #4884,#4804,#4808,#480c,#488c,#4888

	align #100
tabl_2x2_spiral
	dw #4000,#4002,#4004,#4006,#4008,#400a,#400c,#400e,#4010,#4012,#4014,#4016
	dw #4056,#4096,#40d6,#4816,#4856,#4896,#48d6,#5016,#5056,#5096,#50d6,#50d4
	dw #50d2,#50d0,#50ce,#50cc,#50ca,#50c8,#50c6,#50c4,#50c2,#50c0,#5080,#5040
	dw #5000,#48c0,#4880,#4840,#4800,#40c0,#4080,#4040,#4042,#4044,#4046,#4048
	dw #404a,#404c,#404e,#4050,#4052,#4054,#4094,#40d4,#4814,#4854,#4894,#48d4
	dw #5014,#5054,#5094,#5092,#5090,#508e,#508c,#508a,#5088,#5086,#5084,#5082
	dw #5042,#5002,#48c2,#4882,#4842,#4802,#40c2,#4082,#4084,#4086,#4088,#408a
	dw #408c,#408e,#4090,#4092,#40d2,#4812,#4852,#4892,#48d2,#5012,#5052,#5050
	dw #504e,#504c,#504a,#5048,#5046,#5044,#5004,#48c4,#4884,#4844,#4804,#40c4
	dw #40c6,#40c8,#40ca,#40cc,#40ce,#40d0,#4810,#4850,#4890,#48d0,#5010,#500e
	dw #500c,#500a,#5008,#5006,#48c6,#4886,#4846,#4806,#4808,#480a,#480c,#480e
	dw #484e,#488e,#48ce,#48cc,#48ca,#48c8,#4888,#4848,#484a,#484c,#488c,#488a

	savesna "pseudochunk01.sna",SnaStart
	labelslist "label.lbl"