### Q1
``` assembly
INCLUDE Irvine32.inc

.data
    resultMsg BYTE "Result: ", 0

.code
main PROC
    mov eax, 5      

    mov ebx, eax      
    mov ecx, eax    
    
    shl eax, 4        
    shl ebx, 2        
    add eax, ebx      
    add eax, ecx      

   
    mov edx, OFFSET resultMsg
    call WriteString   
    call WriteDec      
    call Crlf         
    
    exit
main ENDP
END main
```
![image](https://github.com/user-attachments/assets/c11dc699-96a9-4e7e-baf7-f6dae8d38fa0)


