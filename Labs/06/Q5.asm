Include irvine32.inc

.data
	arr1 word 1,2,3,4,5
	arr2 word lengthof arr1 dup(?)
.code
	main proc
	mov esi, offset arr1 + (lengthof arr1 - 1) * type arr1
	mov edi, offset arr2
	mov ecx, lengthof arr1
	L1:
		mov ax, [esi]
		mov [edi], ax
		sub esi, type arr1
		add edi, type arr2
		loop L1

	mov ecx, lengthof arr2
	mov esi, offset arr2
	displayArr:
		movzx eax, word ptr [esi]
		call WriteDec
		add esi, type arr2
		call Crlf
		loop displayArr
	exit 

main endp
end main
