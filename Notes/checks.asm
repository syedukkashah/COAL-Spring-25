include Irvine32.inc
.data
    arr dword 7,9,3,5,5,1
    evenNum byte  "found the even number : ", 0
    oddNum byte  "only odd nums in arr", 0
.code
main PROC
   mov eax, 0
   mov ecx, lengthof arr
   mov esi, 0
   L1:
        test arr[esi], 1
        jz found
        add esi, type arr
        loop L1
    
    mov edx, offset oddNum
    call WriteString 
    call Crlf
    jmp done

    found:
        mov edx, offset evenNum
        call WriteString
        mov eax, arr[esi]
        call WriteDec
        call Crlf

   done:    
        exit
main ENDP
end main

