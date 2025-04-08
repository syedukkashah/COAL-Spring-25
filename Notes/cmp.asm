include Irvine32.inc
.data
    op1 word 1
    op2 word 1
    x word ?
.code
main PROC
   mov eax, 0
   mov ax, op1
   cmp ax, op2
   jne _else
   mov x, 1
   jmp _endif
 _else:
    mov x, 2
 _endif:
    movzx eax, x
    call WriteDec
    exit
main ENDP
end main

