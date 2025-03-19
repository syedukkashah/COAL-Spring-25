include irvine32.inc
.data
	A = 0FF10h
	B = 0E10Bh
.code
main proc
	mov eax, A
	mov ebx, B
	call DumpRegs
	call crlf
	xchg eax, ebx
	call DumpRegs
	call crlf

	exit
main endp

end main
