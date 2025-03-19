include Irvine32.inc

.data
	arr byte 61, 43, 11, 52, 25
	my_arr byte lengthof arr DUP(?)
.code
	main proc
	mov al, arr[0]
	mov my_arr[0], al

	mov al, arr[3]
	mov my_arr[1], al

	mov al, arr[1]
	mov my_arr[2], al

	mov al, arr[4]
	mov my_arr[3], al

	mov al, arr[2]
	mov my_arr[4], al

	mov esi, offset my_arr
	movzx eax, byte ptr [esi]
	call WriteDec
	call crlf
	inc esi

	movzx eax, byte ptr [esi]
	call WriteDec
	call crlf
	inc esi

	movzx eax, byte ptr [esi]
	call WriteDec
	call crlf
	inc esi

	movzx eax, byte ptr [esi]
	call WriteDec
	call crlf
	inc esi

	movzx eax, byte ptr [esi]
	call WriteDec
	call crlf
	exit 

main endp
end main
