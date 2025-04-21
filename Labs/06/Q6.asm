Include irvine32.inc

.data
	arr word 52, 34, 67, 1, 100
.code
	main proc
	mov ecx, lengthof arr - 1
	mov ebx, 0
	L1:
		mov edx, ecx
		mov esi, 0
		mov ecx, lengthof arr - 1
		sub ecx, ebx
		L2:
			mov ax, arr[esi]
			cmp ax, arr[esi + type arr]
			jg swap
			jmp skipSwap
			swap:
				xchg ax, arr[esi+type arr]
				mov arr[esi], ax
			skipSwap:
					add esi, type arr
					loop L2
		mov ecx, edx
		inc ebx
		loop L1

		; Display sorted array
		mov ecx, lengthof arr
		mov esi, 0
		printLoop:
			movzx eax, arr[esi]   ; zero-extend to print word
			call WriteDec
			call Crlf
			add esi, type arr
			loop printLoop

	
	exit 

main endp
end main
