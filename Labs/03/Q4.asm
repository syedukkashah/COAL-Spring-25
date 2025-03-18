INCLUDE Irvine32.inc
.data
	color byte "yellow", 0
	A word 12
	B word 2
	Cvar word 13
	D word 8
	E word 14

.code
main PROC
	mov eax, 0
	mov ax, A
	call WriteDec
	call crlf

	mov ax, B
	call WriteDec
	call crlf

	mov ax, Cvar
	call WriteDec
	call crlf

	mov ax, D
	call WriteDec
	call crlf

	mov ax, E
	call WriteDec
	call crlf

	mov edx, offset color
	call WriteString

	exit
MAIN ENDP
END main
