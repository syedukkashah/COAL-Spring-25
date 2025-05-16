### Write a program that defines a global DWORD variable in the .data section, creates a procedure to print its value using WriteDec, and calls the procedure from main using INVOKE. Use ADDR to pass the variable’s address.
```asm
include Irvine32.inc

.code
PrintValue PROC, pValue:PTR DWORD
    push eax ; push eax to save current value
    mov eax, pValue  ; retrieve address 
    mov eax, [eax] ; de reference address to get value 
    call WriteDec
    call Crlf
    pop eax
    ret
PrintValue ENDP

ProcWithLocalVar PROC
    LOCAL localVar:DWORD ; define a local variable of dword type
    mov localVar, 42 
    INVOKE PrintValue, ADDR localVar ; pass address of local var as argument
    ret
ProcWithLocalVar ENDP

main PROC
    call ProcWithLocalVar
    exit
main ENDP
END main
```
### When local var isn't of dword type

```asm
INCLUDE Irvine32.inc

.code
	func2 proc, x: ptr byte 
		mov esi, x ; load address into esi 
		movzx eax, byte ptr [esi]
		call WriteDec
		call Crlf
		ret
	func2 endp
		
	func1 proc
		local var:byte
		mov var, 5
		invoke func2, addr var 
		ret
	func1 endp

	main proc
	call func1
	exit
	main endp
	END main
```
### using enter and leave 

```asm
INCLUDE Irvine32.inc

.code
	func2 proc, x: ptr byte 
		mov esi, x ; load address into esi 
		movzx eax, byte ptr [esi]
		call WriteDec
		call Crlf
		ret
	func2 endp
		
	func1 proc
		enter 4, 0
		mov byte ptr [ebp-1], 5
		lea edx, [ebp-1] ; lea used for getting address of local var
		invoke func2, edx
		leave
		ret
	func1 endp

	main proc
	call func1
	exit
	main endp
	end main
```
