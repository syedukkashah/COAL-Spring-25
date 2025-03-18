INCLUDE Irvine32.inc
.data
	val3 sdword ?
.code
main PROC
	mov eax, 1 
	shl eax, 31   ;shifting to the left by 31 bits
	mov val3, eax
	call DumpRegs
exit
main ENDP
END main
