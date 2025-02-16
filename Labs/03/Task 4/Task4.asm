TITLE String and Integer Declarations
INCLUDE Irvine32.inc

.data
favColor BYTE "Blue", 0  ; Null-terminated string
A WORD 12
B WORD 2
Cval WORD 13 
D WORD 8
E WORD 14

.code
main PROC
    mov ax, A
    mov bx, B
    mov cx, Cval  
    mov dx, D

    call DumpRegs  

    exit
main ENDP
END main
