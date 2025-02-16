TITLE Smallest 2-bit Signed Integer
INCLUDE Irvine32.inc

.data
val3  SBYTE -2  

.code
main PROC
    movsx ax, val3  

    call DumpRegs   

    exit
main ENDP
END main
