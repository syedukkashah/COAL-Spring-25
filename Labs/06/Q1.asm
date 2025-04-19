Include Irvine32.inc
.data
	text byte "fibonacci sequence (up to 9th term)", 0
	temp dword ?
.code
	main proc
	mov eax, 0
	mov edx, offset text
	call WriteString
	call Crlf
	call WriteDec
	call Crlf
	mov ebx, 0
	mov eax, 1
	call WriteDec
	call Crlf
	mov ecx, 9

	printFibonacci:
		mov temp, ebx
		mov ebx, eax
		add eax, temp
		call WriteDec
		call Crlf
		loop printFibonacci
	exit

main endp
end main

