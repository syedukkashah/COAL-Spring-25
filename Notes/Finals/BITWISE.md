### and not or xor 

 these are bit wise operations
 ZF = 1 when result of an operation = 0
 SF = 1 if the dest operand is -ve, & SF = 0 if dest operand is +ve
 OF = 1 when an instruction generates an invalid signed result
 PF = 1 when an instruction generates an even num of 1 bits in the low byte of the dest operand
 ACF = 1 when an operation produces a C out from bit 3 to bit 4

 NOT
```asm
INCLUDE Irvine32.inc

.code
	main proc
	mov eax, 0
	mov al, 11110000b
	call WriteBin
	call Crlf
	call DumpRegs
	call Crlf
	not al	    
	call WriteBin
	call Crlf
	call DumpRegs
	call Crlf
	exit
	main endp
	end main
```
