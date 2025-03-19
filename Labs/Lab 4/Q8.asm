include irvine32.inc
.data
	val1 BYTE 10h
	val2 WORD 8000h
	val3 DWORD 0FFFFh
	val4 WORD 7FFFh
.code
main proc
	inc val1
	movzx eax, val1
	sub eax, val3
	movzx ebx, val2
	movzx ecx, val4
	sub ebx, ecx
	call DumpRegs
	call crlf

	exit
main endp

end main
