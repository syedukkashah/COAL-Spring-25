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

### HOW TO CHECK FOR EVEN NUMBERS
```asm
INCLUDE Irvine32.inc
INCLUDE macros.inc 

.data
	wordVal word 3
.code

; JUMP TO A LABEL IF AN INT IS EVEN

	main proc
	mov ax, wordVal ; al = 3
	and ax, 1
	jz EvenVal ;jump if ZF = 1
	; however, and modifies ax -> to preserve val of ax and modify val of ax, we use test ax, 1
	mWrite "odd integer"
	jmp exitLabel
	EvenVal:
		mWrite "even integer"

	exitLabel:
		exit

	main endp
	end main

```
``` asm
INCLUDE Irvine32.inc

.code
	main proc

	; application of and -> converting char in AL to uppercase 
	; 🧠 Why it works:
    ; Bit 5 (counting from 0) is the "case" bit.
	; Lowercase letters have that bit set to 1.
	;Uppercase letters have it cleared to 0.
	; AND 0xDF forces that bit to 0 — converting to uppercase.

	mov al, 'a' ; al = 01100001b
	and al, 11011111b ; al = 01000001b 

	exit
	main endp
	end main

```




```asm
INCLUDE Irvine32.inc
; OR application -> Convert a binary decimal byte into its equivalent ASCII decimal digit
.code
	main proc
	mov al, 6 ; al = 000000110b
	or al, 00110000b ; al = 00110110b

	;ASCII digits always have bit 4 and bit 5 as 1, 
	;so ORing any 4-bit number (0–9) with 0011 0000 forces that format, 
	;resulting in the correct ASCII digit.

	exit
	main endp
	end main
```
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
