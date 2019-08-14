	device zxspectrum128
	org #6000
SnaStart:
	ld a,low (111*222)

	ld sp,#6000
	ei
	ld a,7
	out (#fe),a
	call genetable
ZaLoop:
	ld a,7
	out (#fe),a
	halt
	dec a
	out (#fe),a
	call restorecoord
	call lissazhu
	jr ZaLoop

lissazhu:
	ld bc,coordbuff
.l0	ld a,0
	ld (put4chunk.l0+1),a
.l1	ld a,0
	ld (put4chunk.l1+1),a
	call put4chunk
	call put4chunk
	call put4chunk

	ld a,(.l0+1)
	add low (51*2)
	ld (put4chunk.l0+1),a
	ld a,(.l1+1)
	add low (32*3)
	ld (put4chunk.l1+1),a
	call put4chunk
	call put4chunk
	call put4chunk

	ld a,(.l0+1)
	add low (102*2)
	ld (put4chunk.l0+1),a
	ld a,(.l1+1)
	add low (64*3)
	ld (put4chunk.l1+1),a
	call put4chunk
	call put4chunk
	call put4chunk

	ld a,(.l0+1)
	add low (153*2)
	ld (put4chunk.l0+1),a
	ld a,(.l1+1)
	add low (96*3)
	ld (put4chunk.l1+1),a
	call put4chunk
	call put4chunk
	call put4chunk

	ld a,(.l0+1)
	add low (204*2)
	ld (put4chunk.l0+1),a
	ld a,(.l1+1)
	add low (128*3)
	ld (put4chunk.l1+1),a
	call put4chunk
	call put4chunk
	call put4chunk

	ld a,(.l0+1)
.l2	add 3
	ld (.l0+1),a
	ld a,(.l1+1)
	add 2
	ld (.l1+1),a
	ret

put4chunk:
	ld h,high sinus
.l0	ld l,0 ;x
	ld e,(hl)
.l1	ld l,0
	ld h,(hl) ;y
	call putchunk
	ld a,(.l0+1)
	add 4 ;2
	ld (.l0+1),a
	ld a,(.l1+1)
	add low (-8*3) ;3
	ld (.l1+1),a
	ret

putchunk:
;h - y
;e - x
	ld a,e
	add 8
	ld e,a
	srl e
	ld l,0
	ld d,l
	srl h
	rr l
	srl h
	rr l
	add hl,de
	add hl,de ;+x*2
	ld de,addresa
	add hl,de
	ld e,(hl)
	inc hl
	ld h,(hl)
	ld l,e
	ld d,h
	rrca
	jr c,.r0
	ld a,%11100000
	or (hl)
	ld (hl),a
	inc h
	ld a,%10100000
	or (hl)
	ld (hl),a
	inc h
	ld a,%11100000
	or (hl)
	ld (hl),a
	jr .r1
.r0	ld a,%00001110
	or (hl)
	ld (hl),a
	inc h
	ld a,%00001010
	or (hl)
	ld (hl),a
	inc h
	ld a,%00001110
	or (hl)
	ld (hl),a
.r1	ld a,l
	ld (bc),a
	inc bc
	ld a,d
	ld (bc),a
	inc bc
	ret

genetable:
	ld hl,addresa
	ld de,#4000
	ld b,48
.l0	push de
	ld c,32
.l1	ld (hl),e
	inc hl
	ld (hl),d
	inc hl
	inc de
	dec c
	jr nz,.l1
	pop de
	inc d
	inc d
	inc d
	INC D
	LD A,D
	AND 7
	JR NZ,.l2 ;CY=0
	LD A,E
	ADD A,32
	LD E,A
	JR C,.l2  ;CY=1
	LD A,D
	ADD A,-8
	LD D,A     ;CY=1
.l2	djnz .l0
	ret
restorecoord:
	xor a
	ld (.savesp+1),sp
	ld sp,coordbuff
	ld b,16
.l0	pop hl
	ld (hl),a
	inc h
	ld (hl),a
	inc h
	ld (hl),a
	djnz .l0
.savesp
	ld sp,#0000
	ret

coordbuff
	dup 16
	db 0,0
	edup

	align #100

sinus:
	incbin "lissazhu.sin"
;	incbin "liss.bin"

	align #100
addresa:
	savesna "lissazhu.sna",SnaStart
	labelslist "label.lbl"