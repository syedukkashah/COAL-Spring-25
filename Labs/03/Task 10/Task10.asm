TITLE Initialize 20-Byte Array
INCLUDE Irvine32.inc

.data
bArray BYTE  1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 
             11, 12, 13, 14, 15, 16, 17, 18, 19, 20  

.code
main PROC
    movzx eax, bArray   
    movzx ebx, bArray+1 
    movzx ecx, bArray+2 
    movzx edx, bArray+3 

    call DumpRegs       
    exit
main ENDP
END main
