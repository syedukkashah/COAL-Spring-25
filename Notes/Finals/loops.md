### WHILE 
```asm
  INCLUDE Irvine32.inc
INCLUDE macros.inc 

.code
	main proc
	; while loop -> if statement followed by the body of a loop followed by an unconditional jump to the top of the loop
	mov eax, 1
	mov ebx, 6

	_while:
		cmp eax, ebx
		je _endWhile
		call WriteInt
		call Crlf
		inc eax
		jmp _while
	_endWhile:
		exit

main endp
end main
```
### DO
```asm
INCLUDE Irvine32.inc
INCLUDE macros.inc 

.code
	main proc
	; do loop -> IF statement, here the body of the loop followed by an IF
    ; statement to unconditional jump
	mov eax, 1
	mov ebx, 6

	;Do
	;{
	;eax = eax + 1;
	;}while( eax < ebx)

	_do:
		inc eax
		cmp eax, ebx
		jae _endDo
		jmp _do
	_endDo:
		exit

main endp
end main
```
