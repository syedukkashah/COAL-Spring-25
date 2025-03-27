INCLUDE Irvine32.inc

.data
    prompt1  BYTE "Enter the first integer: ", 0
    prompt2  BYTE "Enter the second integer: ", 0
    prompt3  BYTE "Enter the third integer: ", 0
    resultMsg BYTE "The sum is: ", 0

.code
main:
   
    mov edx, OFFSET prompt1
    call WriteString
    call ReadInt
    push eax         

    
    mov edx, OFFSET prompt2
    call WriteString
    call ReadInt
    push eax        

   
    mov edx, OFFSET prompt3
    call WriteString
    call ReadInt
    push eax         

    
    pop eax           
    mov ebx, eax      

    pop eax          
    add eax, ebx      

    pop ebx           
    add eax, ebx      

    
    mov edx, OFFSET resultMsg
    call WriteString
    call WriteInt     

    
    exit
end main
