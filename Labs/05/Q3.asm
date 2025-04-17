; if declared array was of type word/dword the sorted array would also be of the same size. The reg vals would then be stored in the 
; relevant extended registers (eax, rax)   
include Irvine32.inc
.data
	arr byte 61, 43, 11, 52, 25
	sorted_arr byte 5 dup(?) 
	msg byte "sorted array: ", 0
.code
	main proc
	;moving arr vals into regs
	mov esi, 0

	mov al, arr[esi]
	add esi, type arr
	mov bl, arr[esi]
	add esi, type arr
	mov cl, arr[esi]
	add esi, type arr
	mov dl, arr[esi]
	add esi, type arr
	mov ah, arr[esi]

	mov esi, 0

	mov sorted_arr[esi], cl
	add esi, type arr
	mov sorted_arr[esi], ah
	add esi, type arr
	mov sorted_arr[esi], bl
	add esi, type arr
	mov sorted_arr[esi], dl
	add esi, type arr
	mov sorted_arr[esi], al
	
	mov esi, 0
	mov ecx, lengthof sorted_arr

	mov edx, offset msg
	call WriteString
	call Crlf
	print:
		movzx eax, sorted_arr[esi]
		add esi, type sorted_arr
		call WriteDec
		call Crlf
		loop print
		
	exit
main endp
end main
