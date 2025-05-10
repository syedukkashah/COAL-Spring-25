INCLUDE Irvine32.inc

.data
array1      DWORD 1, 2, 3, 4, 5
array2      DWORD 10, 20, 30, 40, 50

sum1        DWORD ?
sum2        DWORD ?
totalSum    DWORD ?

.code
main PROC
    CALL SumArray1

    CALL SumArray2

    CALL AddTotals

  
    exit
main ENDP

SumArray1 PROC
    mov esi, OFFSET array1
    mov ecx, 5
    mov eax, 0

sumLoop1:
    add eax, [esi]
    add esi, 4
    loop sumLoop1

    mov sum1, eax
    ret
SumArray1 ENDP

SumArray2 PROC
    mov esi, OFFSET array2
    mov ecx, 5
    mov eax, 0

sumLoop2:
    add eax, [esi]
    add esi, 4
    loop sumLoop2

    mov sum2, eax
    ret
SumArray2 ENDP

AddTotals PROC
    mov eax, sum1
    add eax, sum2
    mov totalSum, eax

    ; Print the result
    mov edx, OFFSET msg
    call WriteString
    mov eax, totalSum
    call WriteInt
    call Crlf

    ret
AddTotals ENDP

.data
msg BYTE "The total sum of both arrays is: ", 0

END main
