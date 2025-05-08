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



### Q2


``` assembly
INCLUDE Irvine32.inc

.code
main PROC
    mov ax, -128      

    movzx eax, ax     
    
    mov ebx, eax      
    shl eax, 16       
    sar eax, 16       

    
    mov ecx, eax     
    rol cx, 8         
    ror cx, 8         
    cwde              
    
    
    call WriteInt      
    call Crlf

    exit
main ENDP
END main

```

![image](https://github.com/user-attachments/assets/6a72ccd7-70cf-4af1-b66f-e2109f441294)


### Q3
``` assembly
INCLUDE Irvine32.inc

.data
    beforeStr BYTE "Before - AX: ",0
    afterStr BYTE "After - BX: ",0

.code
main PROC
    mov ax, 0ABCDh
    mov bx, 1234h

    mov edx, OFFSET beforeStr
    call WriteString
    movzx eax, ax
    call WriteHex
    call Crlf

    mov cx, ax
    shrd bx, cx, 1

    mov edx, OFFSET afterStr
    call WriteString
    movzx eax, bx
    call WriteHex
    call Crlf

    exit
main ENDP
END main
```

![image](https://github.com/user-attachments/assets/ef87b21d-fa0c-4c00-b7dd-0b52cc451530)


### Q4
``` assembly

INCLUDE Irvine32.inc

.data
    val1 SDWORD 20
    val2 SDWORD 5
    val3 SDWORD 2

.code
main PROC
    mov eax, val2
    cdq                
    idiv val3           
    mov ebx, eax        

    ; Calculate (val1 / val2)
    mov eax, val1
    cdq                 
    idiv val2           

   
    imul ebx            


    mov val1, eax

    
    call WriteInt       
    call Crlf

    exit
main ENDP
END main


```

![image](https://github.com/user-attachments/assets/e196f8e3-dd6f-4c2c-a87c-4aa5108d893f)


### Q5

``` assembly
INCLUDE Irvine32.inc

.data
    num1 QWORD 123456789ABCDEF0h    
    num2 QWORD 0FEDCBA9876543210h   
    result QWORD ?                  

.code

Extended_Add proc

    mov eax, [esi]     
    add eax, [edi]      
    mov [ebx], eax      

    mov eax, [esi+4]   
    adc eax, [edi+4]    
    mov [ebx+4], eax    

    ret
Extended_Add ENDP

main PROC

    mov esi, OFFSET num1
    mov edi, OFFSET num2
    mov ebx, OFFSET result

 
    call Extended_Add


    mov eax, DWORD PTR [result+4]  
    call WriteHex
    mov eax, DWORD PTR [result]    
    call WriteHex
    call Crlf

    exit
main ENDP
END main
```

![image](https://github.com/user-attachments/assets/ad5f807a-ffd5-4a40-b128-416fed3c4b30)

