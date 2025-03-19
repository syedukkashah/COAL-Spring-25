include Irvine32.inc

.data
	arrayB byte 10h, 20h, 30h
	arrayW word 100h, 200h, 300h
.code
	main proc
	mov esi, offset arrayB
	mov eax, 0
	mov al, [esi]
	call DumpRegs
	call crlf
	inc esi
	mov al, [esi]
	call DumpRegs
	call crlf

	;for word we add 2/ for dword we add 4 to move to the next element
	mov esi, offset arrayW
	mov ax, [esi]
	call DumpRegs
	call crlf
	add esi, 2
	mov ax, [esi]
	call DumpRegs
	call crlf
	exit 

main endp
end main
