include Irvine32.inc
.data
	myDouble dword 12345678h ; little endian format (78, 56, 34, 12)
.code
	main proc
	mov eax, 0
	mov edx, 0
	mov ax, word ptr myDouble ; word (2 bytes) -> 7856 is stored
	mov dx, word ptr myDouble+2 ; +2 to move to the next 2 bytes -> 3412 is stored
	call DumpRegs
	exit
main endp
end main
