include Irvine32.inc
.data
	aName byte "syed ukkashah", 0
	name_size = ($-aName) - 1
.code
main proc
	mov ecx, name_size
	mov esi, 0
	L1:
		movzx eax, aName[esi] ;get char
		push eax ;push on stack
		inc esi
	loop L1
	mov ecx, name_size
	mov esi, 0
	L2:
		pop eax
		mov aName[esi], al
		inc esi
	loop L2
	mov edx, offset aName
	call WriteString
	exit
main endp
end main
