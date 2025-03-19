include Irvine32.inc

.data
	val1 sdword 8000
.code
	main proc
	mov eax, val1
	call DumpRegs
	call crlf
	inc eax
	call DumpRegs
	call crlf
	exit 

main endp
end main
