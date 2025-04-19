include Irvine32.inc
.data
	array1 BYTE 10, 20, 30, 40
	array2 BYTE 4 DUP (?)
	msg2 byte "reversed array", 0
.code
	main proc
	mov esi, offset array1 + sizeof array1 - type array1
	mov edi, offset array2
	mov ecx, lengthof array1

	copy:
		mov al, [esi]
		mov [edi], al
		inc edi
		dec esi
		loop copy
		
	mov edx, offset msg2
	call WriteString 
	call Crlf
	
	mov esi, 0
	mov ecx, lengthof array2
	print:
		movzx eax, array2[esi]
		call WriteDec
		call Crlf
		inc esi
		loop print

	exit
main endp
end main
