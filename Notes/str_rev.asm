include Irvine32.inc
.data
	source byte "this is the source string", 0
	reversed byte sizeof source dup(0), 0
.code
main proc
	mov eax, 0
	mov esi, sizeof source - 2 ; starting at last char before null terminator
	mov ecx, sizeof source - 1
	mov ebx, 0
	L1:	
		mov al, source[esi]
		mov reversed[ebx], al
		sub esi, type source
		inc ebx
		loop L1
	
	mov edx, offset reversed
	call WriteString
	call crlf
	exit
main endp
end main
