include Irvine32.inc

.data
	list dword 9 dup (34h, 50h, 21h) ; repeat count must be a multiple of the length of he num of individual elements
	; list dword 8 dup (34h, 50h, 21h) won't work
	val1 word 1000h
	val2 sword 10, 20, 30
	array word 10 DUP(?),0
	array2 word 5 DUP(3 DUP(0))
	msg byte 'File not found', 0

.code
	main proc
	mov eax, [list+4] ; prints 50h
	mov ebx, 0
	mov bx, lengthof list ; bx = 1B in hex -> B*1 + 16*1 = 16+11 = 27 (9 duplicates of a 3 int sequence)
	call DumpRegs
	call crlf
	mov eax, 0
	mov ax, LENGTHOF val1 ; AX = 1
	mov ax, LENGTHOF val2 ; AX = 3
	mov ax, LENGTHOF array ; AX = 11
	mov ax, LENGTHOF array2 ; AX = 15
	mov ax, LENGTHOF msg; AX=15
	exit

main endp
end main
