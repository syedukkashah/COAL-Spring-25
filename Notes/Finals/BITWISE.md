 ### these are bit wise operations
 ### ZF = 1 when result of an operation = 0
 ### SF = 1 if the dest operand is -ve, & SF = 0 if dest operand is +ve
 ### OF = 1 when an instruction generates an invalid signed result
 ### PF = 1 when an instruction generates an even num of 1 bits in the low byte of the dest operand
 
 ### ACF = 1 when an operation produces a C out from bit 3 to bit 4
```asm
INCLUDE Irvine32.inc
;  NOT
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
![image](https://github.com/user-attachments/assets/a8a89c31-3e81-419c-bbdd-cca2edccf9d0)





```asm
;AND

INCLUDE Irvine32.inc

.code
	main proc
	mov eax, 0
	mov al, 00111011b
	call WriteBin
	call Crlf
	call DumpRegs
	call Crlf
	and al, 00001111b ; and dest, source  
	call WriteBin
	call Crlf
	call DumpRegs
	call Crlf
	exit
	main endp
	end main
```
![image](https://github.com/user-attachments/assets/8ab149f0-4fc0-4301-aad3-7935d97d519e)


```asm
; XOR

; 1 if bits are different, 0 if bits are same
; XOR dest, source


INCLUDE Irvine32.inc

.code
	main proc
	mov eax, 0
	mov al, 00111011b
	call WriteBin
	call Crlf
	call DumpRegs
	call Crlf
	xor al, 00001111b 
	call WriteBin
	call Crlf
	call DumpRegs
	call Crlf
	exit
	main endp
	end main
```
![image](https://github.com/user-attachments/assets/1bdf3f3d-75c4-4dd6-a815-b4738d308afa)
