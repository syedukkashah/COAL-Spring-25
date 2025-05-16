```asm
INCLUDE Irvine32.inc

.code
	main proc
	mov ecx, 5
	mov eax, 0
	call CalcSum
	call WriteDec
	exit
	main endp

	CalcSum proc
	cmp ecx, 0
	jz L2
	add eax, ecx
	dec ecx
	call CalcSum
	L2: ret
	CalcSum endp
	end main
```
