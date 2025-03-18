include irvine32.inc
.data
	a dword 00010001b
	b dword 00010000b
	_c dword 00110000b
	d dword 01000000b

.code
main proc
	mov ebx, a 
	add ebx, b ; (a+b)
	mov eax, a
	sub eax, b; (a-b)
	sub ebx, eax ; (a+b) - (a-b)
	add ebx, _c
	add ebx, d
	exit
main endp
end main
