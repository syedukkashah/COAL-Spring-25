include irvine32.inc
.data
	Val1 dword 25h
	Val2 byte 36o
	Val3 word 20d
.code
main proc
	mov eax, Val1
	add al, Val2
	sub eax, 654h
	add ax, Val3
	call DumpRegs
	exit
main endp

end main
