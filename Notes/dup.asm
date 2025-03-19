include Irvine32.inc

.data
	list dword 9 dup (34h, 50h, 21h) ; repeat count must be a multiple of the length of he num of individual elements
	; list dword 8 dup (34, 50, 21) won't work
.code
	main proc
	mov eax, [list+4] ; prints 50h
	call DumpRegs
	exit

main endp
end main
