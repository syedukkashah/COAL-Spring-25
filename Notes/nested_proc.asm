include Irvine32.inc
.code
main PROC
    call Sub1
    exit
main ENDP


Sub1 proc
    call Sub2
    ret
Sub1 endp

Sub2 proc
    call Sub3
    ret
Sub2 endp

Sub3 proc
    mov eax, 0
    add eax, 4
    call WriteDec
    ret

Sub3 endp
END main
