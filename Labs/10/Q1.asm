Include Irvine32.inc

.data
	n1 dword 1
	n2 dword 2
	n3 dword 3

.code
	main proc
	push n1
	push n2
	push n3

	call ThreeProd
	call WriteDec
main endp

ThreeProd proc
	mov ebp, esp
	mov eax, 0
	add eax, [ebp + 4]
	add eax, [ebp + 8]
	add eax, [ebp + 12]
	ret
ThreeProd endp
end main
