'''assembly
INCLUDE Irvine32.inc

.data
    resultMsg BYTE "Result: ", 0

.code
main PROC
    ; Example: Compute 5 * 21 (replace with any value)
    mov eax, 5        ; Test case (5 * 21 = 105)
    
    ; Efficient EAX * 21 (21 = 16 + 4 + 1)
    mov ebx, eax      ; EBX = original EAX (5)
    mov ecx, eax      ; ECX = another copy of original EAX (5)
    
    shl eax, 4        ; EAX = EAX * 16 (5*16 = 80)
    shl ebx, 2        ; EBX = original EAX * 4 (5*4 = 20)
    add eax, ebx      ; EAX = 80 + 20 = 100
    add eax, ecx      ; EAX = 100 + 5 = 105 (correct result)

    ; Display result
    mov edx, OFFSET resultMsg
    call WriteString   ; Print "Result: "
    call WriteDec      ; Print EAX (105)
    call Crlf         ; New line
    
    exit
main ENDP
END main
    '''
