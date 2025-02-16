TITLE Unsigned 16-bit Integer Array
INCLUDE Irvine32.inc

.data
myVar WORD 10, 20, 30 

.code
main PROC
    mov ax, myVar      
    mov bx, myVar+2    
    mov cx, myVar+4    

    call DumpRegs      

    exit
main ENDP
END main
