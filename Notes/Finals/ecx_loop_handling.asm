INCLUDE Irvine32.inc
.data
	rows dword 5
	space byte " ", 0
	asterisk byte "*", 0

.code
	main proc
	mov ecx, rows
	mov eax, 0 ;we will use this for spaces
	outer:
		push ecx ;save outer loop counter (num rows)
		mov ecx, eax
		mov edx, offset space
		cmp ecx, 0 
		
		;since space count is 0 on the first row, "loop spaces" first decrements it: ECX = 0 - 1 = FFFFFFFFh 

		; alt method to handles this without loop
		;spaces:
			;cmp ecx, 0
			;je done_spaces
			;call WriteString
			;dec ecx
			;jmp spaces
		;done_spaces:


		je skipSpaces
		spaces:
			call WriteString
			loop spaces
		skipSpaces:
			mov ecx, rows
			sub ecx, eax
			mov edx, offset asterisk
			stars:
				call Writestring
				loop stars
			call Crlf
			pop ecx
			inc eax
	loop outer
	exit
	main endp
	end main
			
			
			
