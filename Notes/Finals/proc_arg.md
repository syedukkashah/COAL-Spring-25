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
