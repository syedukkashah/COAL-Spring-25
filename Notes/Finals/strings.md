### 1. **Direction Flag (DF) and ESI/EDI Behavior**
- The Direction Flag controls whether ESI/EDI are **incremented** or **decremented** after string operations (like MOVSB, MOVSW, MOVSD).
- **CLD (Clear Direction Flag)**  
  - Sets DF=0  
  - ESI/EDI **increment** after each operation (forward copying)  
  - Example:  
    ```asm
    cld               ; DF=0 (forward direction)
    mov esi, source   ; ESI points to start
    mov edi, target   ; EDI points to start
    movsb             ; Copies byte, then ESI++, EDI++
    ```
  
- **STD (Set Direction Flag)**  
  - Sets DF=1  
  - ESI/EDI **decrement** after each operation (backward copying)  
  - Useful when copying overlapping memory (e.g., moving data down in memory).  
  - Example:  
    ```asm
    std               ; DF=1 (backward direction)
    mov esi, source+11 ; ESI points to end
    mov edi, target+11 ; EDI points to end
    movsb             ; Copies byte, then ESI--, EDI--
    ```

---

### 2. **MOVSB, MOVSW, MOVSD - Differences**
| Instruction | Data Size | Effect |
|-------------|----------|--------|
| `MOVSB`     | **Byte** (8-bit)  | Copies `[ESI]` → `[EDI]`, then adjusts ESI/EDI by **1** |
| `MOVSW`     | **Word** (16-bit) | Copies `[ESI]` → `[EDI]`, then adjusts ESI/EDI by **2** |
| `MOVSD`     | **DWord** (32-bit)| Copies `[ESI]` → `[EDI]`, then adjusts ESI/EDI by **4** |

- **Can you use `MOVSW` or `MOVSD` for byte strings?**  
  - **Yes, but carefully!**  
  - If your string length isn't a multiple of 2 (for `MOVSW`) or 4 (for `MOVSD`), you'll copy extra garbage bytes.  
  - Example: Copying "Hello" (5 bytes) with `MOVSW` would copy 6 bytes (3 words), including 1 extra byte.  

---

### 3. **REP Prefix vs. LOOP**
| Feature       | `REP` Prefix | `LOOP` Instruction |
|--------------|-------------|-------------------|
| **How it works** | Repeats `MOVSB/MOVSW/MOVSD` **ECX times** | Decrements ECX and jumps if ECX ≠ 0 |
| **Performance** | Faster (hardware-optimized) | Slower (uses branch prediction) |
| **Usage** | Only with string ops (`MOVSx`, `STOSx`, `LODSx`, `CMPSx`, `SCASx`) | Works with any code block |
| **Example** |  
```asm
mov ecx, 12      ; Copy 12 bytes
rep movsb        ; Auto-repeats MOVSB ECX times
``` |  
```asm
mov ecx, 12      ; Loop 12 times
CopyLoop:
    movsb        ; Manual copy
    loop CopyLoop ; ECX--, jump if ECX≠0
``` |

- **Why prefer `REP`?**  
  - Modern CPUs optimize `REP MOVSB/MOVSW/MOVSD` to use **fast memory copy routines** (like `memcpy`).  
  - No branch misprediction penalty (unlike `LOOP`).  

---

### 4. **Practical Example**
```asm
INCLUDE Irvine32.inc
.data
    source byte "Hello World",0   ; 12 bytes (including null)
    target byte 12 dup(?)         ; Allocate 12 bytes

.code
main PROC
    cld                   ; DF=0 (forward copy)
    mov esi, OFFSET source
    mov edi, OFFSET target
    mov ecx, LENGTHOF source  ; ECX = 12
    rep movsb             ; Copy all 12 bytes

    ; Print result
    mov edx, OFFSET target
    call WriteString      ; Output: "Hello World"
    exit
main ENDP
END main
```

### **Key Takeaways**
1. **Direction Flag (`CLD`/`STD`)** controls whether ESI/EDI increment or decrement.
2. **`MOVSB`/`MOVSW`/`MOVSD`** copy different data sizes (1, 2, or 4 bytes at a time).
3. **`REP` is faster than `LOOP`** for string operations because it’s hardware-optimized.
4. **`MOVSW`/`MOVSD` can copy byte strings**, but must ensure alignment and correct length.

### Moving indexes to the left to delete first index

```asm
INCLUDE Irvine32.inc
.data
	array DWORD 1,1,2,3,4,5,6,7,8,9,10
.code
	main proc
    cld ; df = 0 (forward direction, so esi++, edi++ by movsb)
	mov esi, offset array + type array ;source is one index ahead of target
	mov edi, offset array ; target is current idx starting from 0th
	mov ecx, lengthof array - 1
	rep movsd

	
	mov esi, offset array
	mov ecx, lengthof array - 1
	printArr:
		mov eax, dword ptr [esi]
		call WriteDec
		call Crlf
		add esi, type array
		loop printArr

	exit
main endp
end main
```

```asm
INCLUDE Irvine32.inc
.data
    source word 1234h
    target word 5678h
    msg1 byte "Source > Target",0
    msg2 byte "Source <= Target",0
.code
main proc
    mov esi, offset source
    mov edi, offset target
    cmpsw            ; Compare source and target
    ja L1            ; Jump if source > target (unsigned)
    mov edx, offset msg2
    call WriteString ; Print "Source <= Target"
    jmp exit_prog
L1:
    mov edx, offset msg1
    call WriteString ; Print "Source > Target"
exit_prog:
    exit
main endp
end main
```

```asm
INCLUDE Irvine32.inc
.data
    count = 20
    source dword count dup (?)
    target dword count dup (?)
.code
main proc
    mov ecx, count
    mov esi, offset source
    mov edi, offset target
    cld ; DF = 0, direction = forward
    repe cmpsd ; repeat while equal -> while esi - edi = 0 -> while zf = 0 

    ; this is basically what we do in a normal loop, comparing two elements and checking with the jmp cond (jz)
exit
main endp
end main
```

```asm
INCLUDE Irvine32.inc
.data
    source BYTE "MARTIN  "
    dest BYTE "MARTINEZ"
    str1 BYTE "Source is smaller",0dh,0ah,0
    str2 BYTE "Source is not smaller",0dh,0ah,0
.code
main proc
    cld
    mov esi, offset source
    mov edi, offset dest
    mov ecx, lengthof source
    repe cmpsb ; checks chars by idx (ascii), compares byte by byte untill mismatch
    jb source_smaller
    mov edx, offset str2
    call WriteString 
    call Crlf
    jmp exit_label
    source_smaller:
         mov edx, offset str1
        call WriteString 
        call Crlf
    exit_label:
        exit
   
main endp
end main
```
