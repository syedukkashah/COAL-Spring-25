Include Irvine32.inc
.data
	arrayB BYTE 60, 70, 80
	arrayW WORD 150, 250, 350
	arrayD DWORD 600, 1200, 1800
	msg1 byte "sum of 1st and last element of byte array -> ", 0
	msg2 byte "sum of 1st and last element of word array -> ", 0
	msg3 byte "sum of 1st and last element of dword array -> ", 0
.code
	main proc

	mov esi, offset arrayB
	movzx eax, byte ptr [esi]
	movzx ebx, byte ptr [esi + (lengthof arrayB - 1) * type arrayB]
	add eax, ebx
	mov edx, offset msg1
	call WriteString
	call WriteDec
	call Crlf

	mov esi, offset arrayW
	movzx eax, word ptr [esi]
	movzx ebx, word ptr [esi + (lengthof arrayW - 1) * type arrayW]
	add eax, ebx
	mov edx, offset msg2
	call WriteString
	call WriteDec
	call Crlf

	mov esi, offset arrayD
	mov eax, [esi]
	add eax, [esi+ (lengthof arrayD - 1) * type arrayD]
	mov edx, offset msg3
	call WriteString
	call WriteDec
	call Crlf

	exit

main endp
end main


