
### Q1
```asm
INCLUDE Irvine32.inc

.data
    prompt BYTE "Enter four integers: ",0
    equalMsg BYTE "All numbers are equal",0
    notEqualMsg BYTE "Numbers are not equal",0
    nums DWORD 4 DUP(?)

.code
main PROC
    mov edx,OFFSET prompt
    call WriteString
    
    mov ecx,4
    mov esi,OFFSET nums
InputLoop:
    call ReadInt
    mov [esi],eax
    add esi,4
    loop InputLoop
    
    mov eax,nums
    mov ebx,nums+4
    cmp eax,ebx
    jne NotEqual
    mov ecx,nums+8
    cmp eax,ecx
    jne NotEqual
    mov edx,nums+12
    cmp eax,edx
    jne NotEqual
    
    mov edx,OFFSET equalMsg
    jmp Display
    
NotEqual:
    mov edx,OFFSET notEqualMsg
    
Display:
    call WriteString
    call Crlf
    exit
main ENDP
END main
```

### Q2
```asm

INCLUDE Irvine32.inc

.data
    intArr SWORD 0,0,0,150,120,35,-12,66,4,0
    foundMsg BYTE "First non-zero: ",0

.code
main PROC
    mov esi,OFFSET intArr
    mov ecx,LENGTHOF intArr
    
SearchLoop:
    cmp WORD PTR [esi],0
    jne Found
    add esi,2
    loop SearchLoop
    
    jmp Exit
    
Found:
    mov edx,OFFSET foundMsg
    call WriteString
    movsx eax,WORD PTR [esi]
    call WriteInt
    call Crlf
    
Exit:
    exit
main ENDP
END main
```

### Q3
```asm

INCLUDE Irvine32.inc

.data
    var DWORD 5
    x DWORD ?
    arr SWORD 0,0,0,150,120,35,-12,66,4,0

.code
main PROC
    mov edx,var
    inc edx
    
    mov esi,OFFSET arr
    mov ecx,[esi+6]
    
    cmp var,ecx
    jge ElsePart
    cmp ecx,edx
    jl ElsePart
    
    mov x,0
    jmp Done
    
ElsePart:
    mov x,1
    
Done:
    exit
main ENDP
END main
```

### Q4
```asm

INCLUDE Irvine32.inc

.data
    var DWORD 0
    helloMsg BYTE "Hello",0
    worldMsg BYTE "World",0

.code
main PROC
WhileLoop:
    cmp var,10
    jg EndWhile
    
    cmp var,5
    jge ElsePart
    
    mov edx,OFFSET helloMsg
    jmp Print
    
ElsePart:
    mov edx,OFFSET worldMsg
    
Print:
    call WriteString
    call Crlf
    
    inc var
    jmp WhileLoop
    
EndWhile:
    exit
main ENDP
END main
```

### Q5
```asm

INCLUDE Irvine32.inc

.data
    arr WORD 10,4,7,14,299,156,3,19,29,300,20
    prompt BYTE "Enter number to search: ",0
    foundMsg BYTE "Found",0
    notFoundMsg BYTE "Not found",0

.code
main PROC
    mov edx,OFFSET prompt
    call WriteString
    call ReadInt
    
    mov esi,OFFSET arr
    mov ecx,LENGTHOF arr
    
SearchLoop:
    cmp ax,[esi]
    je Found
    add esi,2
    loop SearchLoop
    
    mov edx,OFFSET notFoundMsg
    jmp Display
    
Found:
    mov edx,OFFSET foundMsg
    
Display:
    call WriteString
    call Crlf
    exit
main ENDP
END main
```

### Q6
```asm

INCLUDE Irvine32.inc

.data
    arr WORD 10,4,7,14,299,156,3,19,29,300,20
    arrSize = ($ - arr) / TYPE arr

.code
main PROC
    mov ecx,arrSize
    dec ecx
    
OuterLoop:
    push ecx
    mov esi,OFFSET arr
    
InnerLoop:
    mov ax,[esi]
    cmp ax,[esi+2]
    jle NoSwap
    xchg ax,[esi+2]
    mov [esi],ax
    
NoSwap:
    add esi,2
    loop InnerLoop
    
    pop ecx
    loop OuterLoop
    
    mov esi,OFFSET arr
    mov ecx,arrSize
    
Display:
    movsx eax,WORD PTR [esi]
    call WriteInt
    mov al,' '
    call WriteChar
    add esi,2
    loop Display
    
    exit
main ENDP
END main
```

### Q7
```asm

INCLUDE Irvine32.inc

.data
    days BYTE "Sunday",0,"Monday",0,"Tuesday",0,"Wednesday",0,"Thursday",0,"Friday",0,"Saturday",0
    prompt BYTE "Enter day number (1-7): ",0
    errorMsg BYTE "Invalid input",0

.code
main PROC
    mov edx,OFFSET prompt
    call WriteString
    call ReadInt
    
    cmp eax,1
    jl Invalid
    cmp eax,7
    jg Invalid
    
    dec eax
    mov ebx,LENGTHOF days
    mul ebx
    mov edx,OFFSET days
    add edx,eax
    call WriteString
    jmp Exit
    
Invalid:
    mov edx,OFFSET errorMsg
    call WriteString
    
Exit:
    call Crlf
    exit
main ENDP
END main
```

### Q8
```asm

INCLUDE Irvine32.inc

.data
    prompt BYTE "Enter a character: ",0
    alphaMsg BYTE "Alphabet",0
    notAlphaMsg BYTE "Not alphabet",0

.code
main PROC
    mov edx,OFFSET prompt
    call WriteString
    call ReadChar
    call WriteChar
    call Crlf
    
    cmp al,'A'
    jb NotAlpha
    cmp al,'Z'
    jbe IsAlpha
    cmp al,'a'
    jb NotAlpha
    cmp al,'z'
    ja NotAlpha
    
IsAlpha:
    mov edx,OFFSET alphaMsg
    jmp Display
    
NotAlpha:
    mov edx,OFFSET notAlphaMsg
    
Display:
    call WriteString
    call Crlf
    exit
main ENDP
END main
```

