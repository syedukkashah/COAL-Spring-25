include Irvine32.inc

.data
	arr1 word  11,21,31,41,51,61,71,81,91,110
	arr2 word  lengthof arr1 dup(?)
	msg byte "copied array", 0
.code
	main proc
	
	mov edx, offset msg
	call WriteString
	call Crlf
	mov ecx, lengthof arr1
	mov esi, offset arr1
	mov edi, offset arr2

	
	L1:
		push [esi]
		pop [edi]
		add esi, type arr1
		add edi, type arr2
		loop L1

	
	mov esi, offset arr2
	mov ecx, lengthof arr2
	L2:
		movzx eax, word ptr [esi]
		add esi, type arr2
		call WriteDec
		call Crlf
		loop L2

		
	
	exit 

main endp
end main
