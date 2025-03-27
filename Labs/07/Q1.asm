INCLUDE Irvine32.inc

.data
    sourceArray DWORD 10, 20, 30, 40, 50, 60, 70, 80, 90, 100  ; Array of 10 integers
    destinationArray DWORD 10 DUP (?)  ; Empty array of 10 integers
    msg1 BYTE "Source Array:", 0
    msg2 BYTE "Destination Array:", 0

.code
main:
    ; Init stack
    lea eax, sourceArray   

   
    mov edx, OFFSET msg1
    call WriteString

   
    call PrintArray

    
    mov ecx, 10            
push_loop:
    mov eax, [eax]         
    push eax               
    add eax, 4             
    loop push_loop         

    ; Display message "Destination Array"
    mov edx, OFFSET msg2
    call WriteString

   
    lea eax, destinationArray 
    mov ecx, 10           
pop_loop:
    pop eax                
    mov [eax], eax         
    add eax, 4            
    loop pop_loop          

    
    call PrintArray

   
    exit

PrintArray PROC
   
    lea eax, destinationArray
    mov ecx, 10
print_loop:
    mov edx, [eax]
    call WriteInt          
    call Crlf            
    add eax, 4            
    loop print_loop
    ret
PrintArray ENDP

END main
