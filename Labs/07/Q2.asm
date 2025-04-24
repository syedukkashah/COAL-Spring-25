include Irvine32.inc
.data
	num1 dword 1
	num2 dword 2
	num3 dword 3
.code
	main proc
	
	push num1
	push num2
	push num3
	
	pop eax
	pop ebx
	pop ecx
	
	add eax, ebx
	add eax, ecx
	call WriteDec
	exit 

main endp
end main
