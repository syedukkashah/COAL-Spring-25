TITLE 16-bit Unsigned Array Declaration
INCLUDE Irvine32.inc

.data
wArray WORD 1000h, 2000h, 3000h  

.code
main PROC
    mov ax, wArray     
    mov bx, wArray+2   
    mov cx, wArray+4    

    call DumpRegs       
    exit
main ENDP
END main
