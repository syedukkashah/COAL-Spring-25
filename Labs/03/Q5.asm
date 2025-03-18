INCLUDE Irvine32.inc
.data
	a dword 11h
	b dword 10h
	cvar dword 30h
	d dword 40h

.code
main PROC
	mov ebx, a 
	add ebx, b ; (a+b)
	mov eax, a
	sub eax, b; (a-b)
	sub ebx, eax ; (a+b) - (a-b)
	add ebx, cvar
	add ebx, d
  ; no call WriteHex since it expects eax and since the question demands the vals to be stored in ebx 
  ; i have shown the register vals by debugging instead of the terminal output
	exit
MAIN ENDP
END main
