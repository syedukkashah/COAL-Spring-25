include irvine32.inc

.data
	varB byte +10
	varW word -150
	varD dword 600

.code
main proc
	movzx eax, varB
	movsx ebx, varW
	mov ecx, varD
	call DumpRegs
	exit
main endp

END main
