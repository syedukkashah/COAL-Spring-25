TITLE Repeat "TEST" 500 Times
INCLUDE Irvine32.inc

.data
testString BYTE 500 dup("TEST"), 0  

.code
main PROC
    mov edx, OFFSET testString  
    call WriteString           
    call Crlf                 
    exit
main ENDP
END main

