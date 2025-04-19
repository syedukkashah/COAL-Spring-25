; subtracting array from right to left
include Irvine32.inc
.data
	array1 dword 10, 20, 30, 40, 50
	res sdword ?
	msg byte "result: ", 0
.code
	main proc
	mov esi, offset array1 + sizeof array1 - type array1
	mov ecx, lengthof array1 - 1
	mov eax, [esi]
	mov res, eax
	copy:
		sub esi, type array1
		mov eax, [esi]
		sub res, eax
		loop copy
		
	mov edx, offset msg
	call WriteString
	mov eax, res
	call WriteInt

	exit
main endp
end main
