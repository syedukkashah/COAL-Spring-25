TITLE Assembly Expressions (expressions.asm)
INCLUDE Irvine32.inc

.code
main PROC
    ; Initialize Registers
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0

    ; Expression 1: edx = eax + 1 + ebx - ecx + 0Ah - 065 + 73d
    mov edx, eax
    add edx, 1
    add edx, ebx
    sub edx, ecx
    add edx, 0Ah        ; 0Ah = 10 (decimal)
    sub edx, 053        ; 065 octal → 53 decimal
    add edx, 73         ; 73d = 73 decimal
    call DumpRegs

    ; Expression 2: eax = 5ADh - ebx + 065 + 65d - 11110111b + 150
    mov eax, 05ADh      ; Hexadecimal (5ADh = 1453 decimal)
    sub eax, ebx
    add eax, 053        ; 065 octal → 53 decimal
    add eax, 65         ; 65d = 65 decimal
    sub eax, 11110111b  ; Binary (11110111 = 247 decimal)
    add eax, 150        ; 150 decimal
    call DumpRegs

    ; Expression 3: ebx = 5ADh - eax + 65d + 073 - 11100101b + 7Bh
    mov ebx, 05ADh      ; 5ADh = 1453 decimal
    sub ebx, eax
    add ebx, 65         ; 65d = 65 decimal
    add ebx, 059        ; 073 octal → 59 decimal
    sub ebx, 11100101b  ; Binary (11100101 = 229 decimal)
    add ebx, 07Bh       ; 7Bh = 123 decimal
    call DumpRegs

    ; Expression 4: ecx = 110010101101b + 45h - 073 + ebx - ecx + 1
    mov ecx, 110010101101b  ; Binary (110010101101 = CADh = 3245 decimal)
    add ecx, 045h           ; 45h = 69 decimal
    sub ecx, 059            ; 073 octal → 59 decimal
    add ecx, ebx
    sub ecx, ecx            ; Reset ecx
    add ecx, 1
    call DumpRegs

    exit
main ENDP
END main
