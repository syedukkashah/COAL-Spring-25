include Irvine32.inc
.data
	myDouble dword 12345678h ; little endian format (78, 56, 34, 12)
	double2 dword 99998888h 
.code
	main proc
	mov eax, 0
	mov edx, 0
	mov ax, word ptr myDouble ; word (2 bytes) -> 5678 is stored
	mov dx, word ptr myDouble+2 ; +2 to move to the next 2 bytes -> 1234 is stored
	call DumpRegs
	call crlf

	; modifying prt of a larger data type
	mov eax, double2
	mov edx, 0
	call DumpRegs
	mov word ptr double2, 6666h 
	mov word ptr double2+2, 3333h
	mov eax, double2
	call crlf
	call DumpRegs
	call crlf
	exit
main endp
end main
