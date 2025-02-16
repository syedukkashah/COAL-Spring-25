TITLE Assembly Equations (equations.asm)
INCLUDE Irvine32.inc

.code
main PROC
    ; Equation 1: 47h + 39h + 60h + 85h + 64h + 54 (octal) - 0Ah
    mov eax, 47h
    add eax, 39h
    add eax, 60h
    add eax, 85h
    add eax, 64h
    add eax, 44  ; Octal 54o = 44 decimal
    sub eax, 0Ah
    call DumpRegs

    ; Equation 2: 30 - 9 + 186 - 150
    mov eax, 30
    sub eax, 9
    add eax, 186
    sub eax, 150
    call DumpRegs

    ; Equation 3: 101110b + 50Ah + 6710d + 1010001b + Fh
    mov eax, 101110b  ; Binary: 101110 = 2Eh
    add eax, 50Ah     ; Hexadecimal: 50Ah = 1290 decimal
    add eax, 6710     ; Decimal: 6710
    add eax, 1010001b ; Binary: 1010001 = 51h
    add eax, 0Fh      ; Hexadecimal: F = 15 decimal
    call DumpRegs

    ; Equation 4: 10001101b - D83h + 385 + 10 + 1111101b - E + F
    mov eax, 10001101b  ; Binary: 10001101 = 8Dh
    sub eax, 0D83h      ; Hexadecimal: D83h = 3459 decimal
    add eax, 385        ; Decimal
    add eax, 10         ; Decimal
    add eax, 1111101b   ; Binary: 1111101 = 7Dh
    sub eax, 0Eh        ; Hexadecimal: E = 14 decimal
    add eax, 0Fh        ; Hexadecimal: F = 15 decimal
    call DumpRegs

    ; Equation 5: 101b - 9 + 1A4h - 569 (octal)
    mov eax, 101b       ; Binary: 101 = 5 decimal
    sub eax, 9          ; Subtract 9 decimal
    add eax, 1A4h       ; Hexadecimal: 1A4h = 420 decimal
    sub eax, 377        ; Octal 569o = 377 decimal
    call DumpRegs

    exit
main ENDP
END main
