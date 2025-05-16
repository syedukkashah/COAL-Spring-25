### Write a program that defines a global DWORD variable in the .data section, creates a procedure to print its value using WriteDec, 
### and calls the procedure from main using INVOKE. Use ADDR to pass the variable’s address.
```asm
include Irvine32.inc

.code
PrintValue PROC, pValue:PTR DWORD
    push eax
    mov eax, pValue
    mov eax, [eax]
    call WriteDec
    call Crlf
    pop eax
    ret
PrintValue ENDP

ProcWithLocalVar PROC
    LOCAL localVar:DWORD
    mov localVar, 42
    INVOKE PrintValue, ADDR localVar
    ret
ProcWithLocalVar ENDP

main PROC
    call ProcWithLocalVar
    exit
main ENDP



END main
```
