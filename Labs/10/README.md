
### Q1
```asm

INCLUDE Irvine32.inc

.data
    Str1 BYTE '127&j~3#^&*#*#45^',0
    foundMsg BYTE "Found at index: ",0
    notFoundMsg BYTE "Not found",0

.code
Scan_String PROC
    mov esi,OFFSET Str1
    mov ecx,0
    
SearchLoop:
    mov al,[esi]
    cmp al,0
    je NotFound
    cmp al,'#'
    je Found
    inc esi
    inc ecx
    jmp SearchLoop
    
Found:
    mov edx,OFFSET foundMsg
    call WriteString
    mov eax,ecx
    call WriteDec
    jmp Exit
    
NotFound:
    mov edx,OFFSET notFoundMsg
    call WriteString
    
Exit:
    call Crlf
    ret
Scan_String ENDP

main PROC
    call Scan_String
    exit
main ENDP
END main
```

### Q2
```asm

INCLUDE Irvine32.inc

.data
    Str1 BYTE '127&j~3#^&*#*#45^',0
    foundMsg BYTE "Found at index: ",0
    notFoundMsg BYTE "Not found",0

.code
Scan_String PROC
    push ebp
    mov ebp,esp
    mov esi,[ebp+8]
    mov al,[ebp+12]
    mov ecx,0
    
SearchLoop:
    mov dl,[esi]
    cmp dl,0
    je NotFound
    cmp dl,al
    je Found
    inc esi
    inc ecx
    jmp SearchLoop
    
Found:
    mov edx,OFFSET foundMsg
    call WriteString
    mov eax,ecx
    call WriteDec
    jmp Exit
    
NotFound:
    mov edx,OFFSET notFoundMsg
    call WriteString
    
Exit:
    call Crlf
    pop ebp
    ret 8
Scan_String ENDP

main PROC
    push '#'
    push OFFSET Str1
    call Scan_String
    exit
main ENDP
END main
```

### Q3
```asm

INCLUDE Irvine32.inc

.data
    Str1 BYTE "Hello",0
    Str2 BYTE "World",0
    equalMsg BYTE "Strings are equal",0
    notEqualMsg BYTE "Strings are not equal",0

.code
IsCompare PROC
    push ebp
    mov ebp,esp
    mov esi,[ebp+8]
    mov edi,[ebp+12]
    
CompareLoop:
    mov al,[esi]
    mov bl,[edi]
    cmp al,bl
    jne NotEqual
    cmp al,0
    je Equal
    inc esi
    inc edi
    jmp CompareLoop
    
Equal:
    mov edx,OFFSET equalMsg
    jmp Display
    
NotEqual:
    mov edx,OFFSET notEqualMsg
    
Display:
    call WriteString
    call Crlf
    pop ebp
    ret 8
IsCompare ENDP

main PROC
    push OFFSET Str2
    push OFFSET Str1
    call IsCompare
    exit
main ENDP
END main
```

### Q4
```asm

INCLUDE Irvine32.inc

.data
    Str1 BYTE "Hello World",0

.code
Str_Reverse PROC
    push ebp
    mov ebp,esp
    mov esi,[ebp+8]
    mov edi,esi
    
FindEnd:
    cmp BYTE PTR [edi],0
    je FoundEnd
    inc edi
    jmp FindEnd
    
FoundEnd:
    dec edi
    
SwapLoop:
    cmp esi,edi
    jge Done
    mov al,[esi]
    mov bl,[edi]
    mov [esi],bl
    mov [edi],al
    inc esi
    dec edi
    jmp SwapLoop
    
Done:
    pop ebp
    ret 4
Str_Reverse ENDP

main PROC
    push OFFSET Str1
    call Str_Reverse
    mov edx,OFFSET Str1
    call WriteString
    call Crlf
    exit
main ENDP
END main
```

### Q5
```asm
INCLUDE Irvine32.inc

.data
    array DWORD 10 DUP(?)
    multiplier DWORD 5

.code
Load PROC
    push ebp
    mov ebp,esp
    mov esi,[ebp+8]
    mov ecx,[ebp+12]
    mov ebx,0
    
FillLoop:
    mov eax,ebx
    imul eax,multiplier
    mov [esi],eax
    add esi,4
    inc ebx
    loop FillLoop
    
    pop ebp
    ret 8
Load ENDP

main PROC
    push LENGTHOF array
    push OFFSET array
    call Load
    
    mov esi,OFFSET array
    mov ecx,LENGTHOF array
    
Display:
    mov eax,[esi]
    call WriteInt
    mov al,' '
    call WriteChar
    add esi,4
    loop Display
    
    call Crlf
    exit
main ENDP
END main
```
