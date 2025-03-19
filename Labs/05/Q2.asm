include Irvine32.inc

.data
	val1 sdword 8000
.code
	main proc
	mov ax, 77F0h
	add al, 10h 
	call DumpRegs
	call crlf
	add ah, 1
	call DumpRegs
	call crlf
	add ax, 2
	call DumpRegs
	call crlf
	exit 

main endp
end main
