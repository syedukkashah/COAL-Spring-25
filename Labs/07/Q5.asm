INCLUDE Irvine32.inc

.data
prompt BYTE "Enter a number: ", 0
resultMsg BYTE "The sum from 1 to n is: ", 0

.code
main PROC
    call GetSumToN

    exit
main ENDP


GetSumToN PROC
    push ecx
    push eax

    
    mov edx, OFFSET prompt
    call WriteString
    call ReadInt       
    mov ecx, eax      
    mov eax, 0         

sumLoop:
    add eax, ecx
    loop sumLoop

   
    mov edx, OFFSET resultMsg
    call WriteString
    call WriteInt
    call Crlf

    pop eax
    pop ecx
    ret
GetSumToN ENDP

END main
