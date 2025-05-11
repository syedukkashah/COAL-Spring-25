
### Q1
```asm
.386
.model flat, stdcall
.stack 4096
INCLUDE Irvine32.inc

.data
    num1 DWORD 5
    num2 DWORD 7
    num3 DWORD 3

.code
ThreeProd PROC
    push ebp
    mov ebp, esp
    mov eax, [ebp+8]
    imul eax, [ebp+12]
    imul eax, [ebp+16]
    call WriteDec
    pop ebp
    ret 12
ThreeProd ENDP

main PROC
    push num3
    push num2
    push num1
    call ThreeProd
    exit
main ENDP
END main
```
![image](https://github.com/user-attachments/assets/efb67b9c-72fd-4608-98a4-a86dd0e222b2)

### Q2
```asm
.386
.model flat, stdcall
.stack 4096
INCLUDE Irvine32.inc

.data
    arr DWORD 20, 15, 25, 10, 30, 5, 40, 35, 50, 45, 
              60, 55, 70, 65, 80, 75, 90, 85, 100, 95
    arrSize = ($ - arr) / TYPE arr

.code
MinMaxArray PROC
    push ebp
    mov ebp, esp
    mov esi, [ebp+8]
    mov ecx, [ebp+12]
    mov eax, [esi]
    mov ebx, [esi]
    add esi, 4
    dec ecx

L1: cmp [esi], eax
    jg NotMin
    mov eax, [esi]
NotMin:
    cmp [esi], ebx
    jl NotMax
    mov ebx, [esi]
NotMax:
    add esi, 4
    loop L1

    call WriteInt
    mov al, ' '
    call WriteChar
    mov eax, ebx
    call WriteInt
    pop ebp
    ret 8
MinMaxArray ENDP

main PROC
    push arrSize
    push OFFSET arr
    call MinMaxArray
    exit
main ENDP
END main
```
![image](https://github.com/user-attachments/assets/27d1bfc3-7bea-496f-a4e3-3aaa5e03cace)

### Q3
```asm
.386
.model flat, stdcall
.stack 4096
INCLUDE Irvine32.inc

.code
LocalSquare PROC
    enter 4, 0
    call ReadInt
    mov [ebp-4], eax
    imul eax, eax
    call WriteDec
    leave
    ret
LocalSquare ENDP

main PROC
    call LocalSquare
    exit
main ENDP
END main
```
![image](https://github.com/user-attachments/assets/10c27bb2-7e9f-4e25-9dbf-211676d2a86e)

### Q4 
```asm
.386
.model flat, stdcall
.stack 4096
INCLUDE Irvine32.inc

.data
    nums DWORD 4 DUP(?)
    allPrime BYTE 1

.code
CheckPrime PROC
    push ebp
    mov ebp, esp
    mov eax, [ebp+8]
    cmp eax, 2
    jl NotPrime
    mov ecx, 2

TestLoop:
    mov edx, 0
    div ecx
    cmp edx, 0
    je NotPrime
    inc ecx
    mov eax, [ebp+8]
    cmp ecx, eax
    jl TestLoop
    mov eax, 1
    jmp Done

NotPrime:
    mov eax, 0

Done:
    pop ebp
    ret 4
CheckPrime ENDP

LargestPrime PROC
    push ebp
    mov ebp, esp
    mov esi, [ebp+8]
    mov ecx, 4
    mov eax, [esi]

FindMax:
    cmp [esi], eax
    jle Next
    mov eax, [esi]
Next:
    add esi, 4
    loop FindMax
    call WriteInt
    pop ebp
    ret 4
LargestPrime ENDP

main PROC
    mov ecx, 4
    mov esi, OFFSET nums

InputLoop:
    call ReadInt
    mov [esi], eax
    add esi, 4
    loop InputLoop

    mov ecx, 4
    mov esi, OFFSET nums

CheckLoop:
    push [esi]
    call CheckPrime
    cmp eax, 0
    je NotAllPrime
    add esi, 4
    loop CheckLoop
    jmp AllPrime

NotAllPrime:
    mov allPrime, 0

AllPrime:
    cmp allPrime, 0
    je Exit
    push OFFSET nums
    call LargestPrime

Exit:
    exit
main ENDP
END main
```

### Q5
```asm
.386
.model flat, stdcall
.stack 4096
INCLUDE Irvine32.inc

.data
    arr DWORD 9, 2, 7, 1, 5, 8, 3, 6, 4, 0
    arrSize = ($ - arr) / TYPE arr

.code
BubbleSort PROC
    push ebp
    mov ebp, esp
    mov esi, [ebp+8]
    mov ecx, [ebp+12]
    dec ecx

OuterLoop:
    push ecx
    mov edi, esi

InnerLoop:
    mov eax, [edi]
    cmp eax, [edi+4]
    jle NoSwap
    xchg eax, [edi+4]
    mov [edi], eax
NoSwap:
    add edi, 4
    loop InnerLoop
    pop ecx
    loop OuterLoop
    pop ebp
    ret 8
BubbleSort ENDP

main PROC
    push arrSize
    push OFFSET arr
    call BubbleSort
    mov esi, OFFSET arr
    mov ecx, arrSize

Display:
    mov eax, [esi]
    call WriteInt
    mov al, ' '
    call WriteChar
    add esi, 4
    loop Display
    exit
main ENDP
END main
```
