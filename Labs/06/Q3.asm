Include irvine32.inc

.data
	txt byte "Employee ", 0
	msg1 byte "Enter Employee ID: ", 0
	msg2 byte "Enter name: ", 0
	msg3 byte "Enter year of birth: ", 0
	msg4 byte "Enter annual salary: ", 0
	msg5 byte "Annual salary of all employees: ", 0
	buffer byte 30 dup(?)
	salaries dword 5 dup(?)
.code
	main proc
	mov ecx, lengthof salaries
	mov ebx, 1
	mov esi, offset salaries
	L1:
		mov edx, offset txt
		call WriteString
		mov eax, ebx
		call WriteDec
		inc ebx
		call Crlf

		mov edx, offset msg1
		call WriteString
		call ReadInt

		push ecx ;save loop counter 

		mov edx, offset msg2
		call WriteString
		mov edx, offset buffer
		mov ecx, sizeof buffer ;buffer length
		call ReadString

		pop ecx ;restore loop counter 

		mov edx, offset msg3
		call WriteString
		call ReadInt

		mov edx, offset msg4
		call WriteString
		call ReadInt
		mov [esi], eax

		add esi, type salaries
		call Crlf
		loop L1

	mov esi, 0
	mov ecx, lengthof salaries
	mov ebx, 0
	L2:
		mov eax, salaries[esi]
		add ebx, eax
		add esi, type salaries
		loop L2

	mov edx, offset msg5
	call WriteString
	mov eax, ebx
	call WriteDec
	exit 

main endp
end main
