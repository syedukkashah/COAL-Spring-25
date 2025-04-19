INCLUDE Irvine32.inc
.code
	main PROC

	mov eax, 1

	mov ebx, eax
	mov ecx, 4 

	L1:
		mov edx, ecx
		mov ecx, ebx
		L2:
			call WriteDec
			loop L2
		inc ebx
		mov ecx, edx
		call Crlf
		loop L1

	call Crlf

	mov ebx, 4
	mov ecx, 4

	_L1:
		mov edx, ecx
		mov ecx, ebx
		_L2:
			call WriteDec
			loop _L2
		dec ebx
		mov ecx, edx
		call Crlf
		loop _L1

	call Crlf

	mov ecx, 4
	mov ebx, 4

	L1_:
		mov edx, ecx
		mov ecx, ebx
		mov eax, 4
		L2_:
			call WriteDec
			dec eax
			loop L2_
		dec ebx
		mov ecx, edx
		call Crlf
		loop L1_

	call Crlf

	mov ecx, 4
	mov ebx, 4

	L1__:
		mov edx, ecx
		mov ecx, ebx
		mov eax, 1
		L2__:
			call WriteDec
			inc eax
			loop L2__
		dec ebx
		mov ecx, edx
		call Crlf
		loop L1__
		
	exit
	main ENDP
	end main
