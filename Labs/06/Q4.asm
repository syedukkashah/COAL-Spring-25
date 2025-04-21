Include irvine32.inc

.data
	msg1 byte "source string: ", 0
	msg2 byte "copied string: ", 0
	source byte "hello world", 0
	target byte lengthof source - 1 dup(?), 0

.code
	main proc
	mov esi, 0
	mov ecx, lengthof source - 1
	L1:
		mov al, source[esi*type source]
		mov target[esi*type source], al
		inc esi
		loop L1

	mov edx, offset msg1
	call WriteString
	mov edx, offset source 
	call WriteString
	call Crlf
	mov edx, offset msg2
	call WriteString
	mov edx, offset target
	call WriteString
	call Crlf

	exit 

main endp
end main

