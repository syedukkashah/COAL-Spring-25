TITLE Uninitialized DWORD Array
INCLUDE Irvine32.inc

.data
dArray DWORD 50 dup(?)  

.code
main PROC
    mov dword ptr dArray, 1000h  
    mov dword ptr dArray+4, 2000h  
    mov dword ptr dArray+8, 3000h 

    mov eax, dArray     
    mov ebx, dArray+4    
    mov ecx, dArray+8    

    call DumpRegs 
    exit
main ENDP
END main
