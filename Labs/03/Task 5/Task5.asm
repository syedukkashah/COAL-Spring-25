TITLE Expression Calculation in Assembly
INCLUDE Irvine32.inc

.data
a BYTE 11h
b BYTE 10h
cVal BYTE 30h
d BYTE 40h

.code
main PROC
    ; Load b into AL
    mov al, b      ; AL = b (10h)
    add al, b      ; AL = 2b

    ; Add c
    add al, cVal      ; AL = 2b + c

    ; Add d
    add al, d      ; AL = 2b + c + d

    ; Move result to EBX (Zero-extend AL to EAX first)
    movzx ebx, al  ; EBX = final result

    call DumpRegs  ; Display registers
    exit
main ENDP
END main
