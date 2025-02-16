TITLE Binary Data Implementation
INCLUDE Irvine32.inc

.data
a BYTE 00010001b  ; 11h = 17 decimal
b BYTE 00010000b  ; 10h = 16 decimal
cval BYTE 00110000b  ; 30h = 48 decimal
d BYTE 01000000b  ; 40h = 64 decimal

.code
main PROC
    ; Load b into AL
    mov al, b      ; AL = b (00010000b = 16)
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
