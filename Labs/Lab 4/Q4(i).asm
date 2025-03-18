include irvine32.inc

.code
main proc
	mov eax, 89
	add eax, 75Fh
	sub eax, 38
	sub eax, 28
	add eax, 1101b
	call DumpRegs
	exit
main endp

end main
