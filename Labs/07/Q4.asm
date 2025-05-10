INCLUDE Irvine32.inc

.data
columns DWORD 5

space BYTE " ", 0
star  BYTE "*", 0

.code
main PROC
    mov eax, columns
    push eax

    call PrintRightTriangle

    exit
main ENDP

PrintRightTriangle PROC
    push ebp
    mov ebp, esp       

    push ecx
    push edx
    push ebx

    mov eax, [ebp+8]   
    mov ecx, eax       
    mov ebx, 1         

print_rows:
    push ecx          
    mov ecx, eax
    sub ecx, ebx       
print_spaces:
    cmp ecx, 0
    jle done_spaces
    mov edx, OFFSET space
    call WriteString
    loop print_spaces
done_spaces:
    pop ecx            
    mov ecx, ebx       
print_stars:
    cmp ecx, 0
    jle done_stars
    mov edx, OFFSET star
    call WriteString
    loop print_stars
done_stars:
    call Crlf
    inc ebx
    cmp ebx, eax
    jle print_rows

    ; Clean up
    pop ebx
    pop edx
    pop ecx
    pop ebp
    ret 4             
PrintRightTriangle ENDP

END main
