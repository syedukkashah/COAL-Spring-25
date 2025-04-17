include Irvine32.inc
.data
	arrayB byte 10, 20, 30
	arrayW word 150, 250, 350 
	arrayD dword 600, 1200, 1800
	sum1 dword ?
	sum2 dword ?
	sum3 dword ?
	msg1 byte "sum1: ", 0
	msg2 byte "sum2: ", 0
	msg3 byte "sum3: ", 0
.code
	main proc
	movzx eax, arrayB[0]
	add ax, arrayW[0]
	add eax, arrayD[0]
	mov sum1, eax

	movzx eax, arrayB[1]
	add ax, arrayW[2]
	add eax, arrayD[4]
	mov sum2, eax

	movzx eax, arrayB[2]
	add ax, arrayW[4]
	add eax, arrayD[8]
	mov sum3, eax

	mov eax, sum1
	mov edx, offset msg1
	call WriteString
	call WriteDec
	call Crlf

	mov eax, sum2
	mov edx, offset msg2
	call WriteString
	call WriteDec
	call Crlf

	mov eax, sum3
	mov edx, offset msg3
	call WriteString
	call WriteDec
	call Crlf
		
	exit
main endp
end main
