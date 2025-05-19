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








Yes, exactly! Let’s clarify why `dec edi` is needed in your program and confirm your understanding about the `repne scasb` behavior when the zero flag (`ZF`) is set to 1 upon finding 'F'.

### Your Program Recap
Your code searches for the character 'F' in the string `"ABXDEFGH",0` using `repne scasb`:

```asm
INCLUDE Irvine32.inc
.data
    str1 byte "ABXDEFGH",0
.code
main proc
    mov edi, offset str1
    mov al, 'F'
    mov ecx, lengthof str1
    cld
    repne scasb
    jnz quit
    dec edi
    quit: exit
main endp
end main
```

### using scasb to "scan string byte". repne scasb increment edi if cld 
### Key Question: Why `dec edi`?
You’re correct that when `ZF = 1` (because 'F' is found), `repne scasb` still increments `EDI`, and that’s precisely why the `dec edi` instruction is included before exiting. Let’s break it down:

1. **Behavior of `scasb`**:
   - The `scasb` instruction:
     - Compares the byte in `AL` ('F') with the byte at `[EDI]` (the current string position).
     - Sets the zero flag (`ZF`):
       - `ZF = 1` if `AL == [EDI]` (match found).
       - `ZF = 0` if `AL != [EDI]` (no match).
     - **Always** updates `EDI` and `ECX`:
       - Increments `EDI` (since `DF = 0` via `cld`) to point to the next byte.
       - Decrements `ECX` to reduce the remaining count.
     - This happens *regardless* of whether a match is found.

2. **Behavior of `repne scasb`**:
   - The `repne` (repeat while not equal) prefix repeats `scasb` as long as:
     - `ECX > 0` (bytes remain to scan).
     - `ZF = 0` (no match found yet).
   - When a match is found (`AL == [EDI]`, so `ZF = 1`):
     - `scasb` *still performs its full operation* for that byte, including incrementing `EDI` and decrementing `ECX`.
     - Then, because `ZF = 1`, `repne` stops, and no further `scasb` iterations occur.
   - So, if 'F' is found, `EDI` ends up pointing to the *next byte* after 'F'.

3. **What Happens in Your Case**?
   - Let’s trace the execution for `str1 = "ABXDEFGH",0`:
     - Initial state: `EDI` points to 'A', `AL = 'F'`, `ECX = 9`, `DF = 0`.
     - `repne scasb` scans:
       - 'A': `ZF = 0`, `EDI` → 'B', `ECX = 8`.
       - 'B': `ZF = 0`, `EDI` → 'X', `ECX = 7`.
       - 'X': `ZF = 0`, `EDI` → 'D', `ECX = 6`.
       - 'D': `ZF = 0`, `EDI` → 'E', `ECX = 5`.
       - 'E': `ZF = 0`, `EDI` → 'F', `ECX = 4`.
       - 'F': `AL == [EDI]` (`46h == 46h`), so `ZF = 1`. `scasb` *still* increments `EDI` to point to 'G' and decrements `ECX` to 3.
     - Since `ZF = 1`, `repne scasb` stops.
   - After `repne scasb`:
     - `EDI` points to 'G' (the byte after 'F').
     - `ZF = 1` (match found).
     - `ECX = 3` (6 bytes scanned: 'A', 'B', 'X', 'D', 'E', 'F').

4. **Role of `jnz quit`**:
   - The `jnz quit` instruction checks `ZF`:
     - If `ZF = 0` (no match or `ECX = 0`), it jumps to `quit` and exits.
     - If `ZF = 1` (match found, as in this case), it continues to `dec edi`.
   - Since 'F' is found, `ZF = 1`, so the program proceeds to `dec edi`.

5. **Why `dec edi`?**
   - After `repne scasb`, `EDI` points to 'G' (the byte after 'F') because `scasb` incremented `EDI` during the matching iteration.
   - If you want `EDI` to point to the location of 'F' (e.g., for further processing or to return the position of the match), you need to decrement `EDI` by 1 to move it back to 'F'.
   - The `dec edi` instruction does exactly that: it adjusts `EDI` to point to 'F'.

6. **What If You Didn’t Use `dec edi`?**
   - Without `dec edi`, `EDI` would remain pointing to 'G'. If the program (or a caller) needed the address of the found 'F', it would be incorrect.
   - In your specific program, you exit immediately after `dec edi`, so the adjusted `EDI` isn’t used further. However, including `dec edi` is good practice because:
     - It ensures `EDI` points to the found character, which is typically the desired result of a string search.
     - It makes the code reusable in contexts where the position of 'F' is needed (e.g., for string manipulation or output).

7. **What If 'F' Isn’t Found?**
   - If 'F' were not in the string (e.g., `str1 = "ABXDEGH",0`):
     - `repne scasb` would scan all 8 bytes until `ECX = 0`.
     - `ZF` would remain 0 (no match found).
     - `EDI` would point to the byte after the null terminator.
     - `jnz quit` would jump to `quit` (since `ZF = 0`), skipping `dec edi`.
     - In this case, `dec edi` is irrelevant because no match was found, and the program exits.

### Your Understanding Confirmed
You’re absolutely correct:
- When `ZF = 1` (because 'F' is found), `repne scasb` still increments `EDI` as part of the `scasb` operation for that byte.
- This leaves `EDI` pointing to the *next* byte (e.g., 'G').
- The `dec edi` instruction is included to correct this, moving `EDI` back to point to 'F' before the program exits.

### Why Does `scasb` Increment `EDI` Even on a Match?
- The x86 architecture defines `scasb` as a single instruction that always performs three actions:
  1. Compares `AL` with `[EDI]` and sets flags (including `ZF`).
  2. Increments or decrements `EDI` (based on `DF`).
  3. Decrements `ECX` (if used with `repne`).
- These actions are indivisible within one `scasb` execution. Even when a match is found, `scasb` completes all steps before `repne` checks `ZF` to decide whether to stop.
- This is why `EDI` is incremented *before* `repne` halts the loop, requiring `dec edi` to adjust it.

### Practical Note
- In your program, `dec edi` is technically unnecessary because the program exits immediately (`exit`) and doesn’t use `EDI` further. However, it’s included to ensure `EDI` points to the found character, which is standard practice in string-search routines (e.g., for compatibility with calling code or future extensions).
- If you were to extend the program (e.g., to print the address of 'F' or modify the string at that position), `dec edi` would be critical.

### Example with Context
If you wanted to verify where `EDI` points after finding 'F', you could add an Irvine32 call to display `EDI`’s value or the character at `[EDI]`. For example:

```asm
INCLUDE Irvine32.inc
.data
    str1 byte "ABXDEFGH",0
.code
main proc
    mov edi, offset str1
    mov al, 'F'
    mov ecx, lengthof str1
    cld
    repne scasb
    jnz quit
    dec edi
    mov al, [edi]       ; Load the byte at EDI (should be 'F')
    call WriteChar      ; Irvine32: Print the character (displays 'F')
quit:
    exit
main endp
end main
```

- Without `dec edi`, `[EDI]` would point to 'G', and `WriteChar` would display 'G'.
- With `dec edi`, `[EDI]` points to 'F', and `WriteChar` correctly displays 'F'.

### Key Takeaways
- When `ZF = 1` (match found for 'F'), `scasb` still increments `EDI` as part of its operation, leaving `EDI` pointing to the next byte ('G').
- The `dec edi` instruction corrects this by moving `EDI` back to point to 'F'.
- This adjustment is necessary if the program or caller needs the exact position of the found character, even though your program exits immediately.
- Your understanding is spot-on: `dec edi` is there because `repne scasb` increments `EDI` even when it finds the match.


### STOSB, STOSW, STOSD
```asm
;The stosb, stosw, and stosd instructions differ in the size of the data they store:

;stosb: Stores a byte (8 bits, 1 byte at a time ) from AL, increments EDI by 1.
;stosw: Stores a word (16 bits, 2 bytes at a time) from AX, increments EDI by 2.
;stosd: Stores a doubleword (32 bits, 4 bytes at a time) from EAX, increments EDI by 4.

;to use stosw or stosd, you need to adjust:

;The source register (AL → AX or EAX).
;The value to store (byte → word or doubleword).
;The array size and ECX (to account for larger elements).
;The interpretation of the output (since WriteString expects bytes).

INCLUDE Irvine32.inc
.data
    count = 100
    strB byte count dup(?), 0
    strW word count dup(?), 0
    strD dword count dup(?), 0
.code
main proc
    mov al, "s" ; val to be stored
    mov edi, offset strB ; storing address of string into edi
    mov ecx, count ; init ecx to length of str
    cld ; df = 0 -> forward direction
    rep stosb ; fill with contents of al (store string byte) 

    mov edx, offset strB
    call WriteString
    call Crlf

    mov ax, "hh" ;since stosw write 2 bytes at a time, we must ensure both bytes in ax contain h to avoid terminator in str (h0h0h0...)
    mov edi, offset strW
    mov ecx, count/2 ;two bytes written 50 times  = 100 words
    cld
    rep stosw

    mov edx, offset strW
    call WriteString 
    call Crlf

    mov eax, "aaaa"
    mov edi, offset strD
    mov ecx, count/4
    cld
    rep stosd

    mov edx, offset strD
    call WriteString
    call Crlf
    exit
main endp
end main
```
### LODSB, LODSW, LODSD

```asm
; lodsb, lodsw, lodsd loads a byte/word/dword from memory at esi into al,ax,eax
; rep prefix is barely used with lods because each new val loaded into the accumulator overwrites it's previous contents
; instead, lods is used to load a single val

INCLUDE Irvine32.inc
.data
    array dword 1,2,3,4,5,6,7,8,9,10 ; test data
    multiplier dword 10 ; test data
    multiplierW word 10
    arrayW word 1,2,3,4,5,6,7,9,10
.code
main proc

    cld
    mov esi, offset array
    mov edi, esi
    mov ecx, lengthof array
    L1: lodsd ; load [esi] into eax
    mul multiplier ; multiply by a value
    stosd ; store eax into [edi]
    loop L1

    cld
    mov esi, offset arrayW
    mov edi, esi
    mov ecx, lengthof arrayW
    L2:
    lodsw; load val from [esi] to eax
    mul multiplierW ; ax*=10
    stosw ; store val at ax to [edi]
    loop L2
    exit
main endp
end main
```

### Write a program that converts each unpacked binary-coded decimal byte belonging to an array into an ASCII decimal byte and copies it to a new array.

```asm
INCLUDE Irvine32.inc
.data
    array byte 1,2,3,4,5,6,7,8,9
    dest byte lengthof array dup(?)
.code
main proc
    mov ecx, lengthof array
    cld ; df = 0, forward direction (LR)
    mov esi, offset array
    mov edi, offset dest
    l1:
    lodsb ; loads [esi] to eax
    or al, 00110000b ;converting decimal to eqivalent ascii val
    stosb ; storing eax in [edi]
    loop l1
    
    mov ecx, lengthof dest
    mov esi, offset dest
    mov eax, 0
    printLoop:
    mov al, byte ptr[esi]
    call WriteDec
    call Crlf
    add esi, type dest
    loop printLoop
    exit
main endp
end main
```
### Search for the character 'L' in the string "HelloWorld",0 using SCASB. If found, print its 0-based position (e.g., 3 for the first 'L'). If not found, print "Not found".
```asm
INCLUDE Irvine32.inc
.data
    str1 byte "HelloWorld", 0
    msg byte "not found"
.code
main proc
    mov edi ,offset str1
    mov esi, 0
    mov ecx, lengthof str1
    mov al, 'l'
    cld
    repne scasb
    jnz NF 
    ; we can calculate what position the letter was founf at by subtracting the remaining ecx from the length of the array
    mov eax, lengthof str1
    sub eax, ecx
   call WriteDec
   call Crlf
   jmp exitLabel
    NF:
        mov edx, offset msg
        call WriteString
        call Crlf
    exitLabel:
        exit
main endp
end main
```


### Compare two strings "TestCase",0 and "TestCade",0 using CMPSB. Print "Strings are equal" if they match, or "Strings differ at position X" where X is the 1-based position of the first mismatch.

```asm
INCLUDE Irvine32.inc
.data
    str1 byte "TestCase", 0
    str2 byte "TestCade", 0
    msg byte "strings differ at index: ", 0
    msg2 byte "strings are equal", 0
.code
main proc
    mov esi ,offset str1
    mov edi ,offset str2
    mov ecx, lengthof str1
    cld
    repe cmpsb
    jz equal
    mov edx, offset msg
    call WriteString
    ; we can calculate what position the mismatch occured at by subtracting the remaining ecx from the length of the array
    mov eax, lengthof str1
    sub eax, ecx
    dec eax ;even though mismatch was found, cmpsb will still increment esi and edi (idx= 7 so we dec to go back 1 idx)
   call WriteDec
   call Crlf
   jmp exitLabel
    equal:
        mov edx, offset msg2
        call WriteString
        call Crlf
    exitLabel:
        exit
main endp
end main
```

### Copy the string "abcde",0 to a destination array, converting each character to uppercase (e.g., 'a' → 'A') using LODSB and STOSB. Print the result with WriteString.

```asm
INCLUDE Irvine32.inc
.data
    str1 byte "abcde",0
    str2 byte lengthof str1 dup(?)
.code
main proc
    mov esi ,offset str1
    mov edi ,offset str2
    mov ecx, lengthof str1 - 1
    cld
    L1:
        lodsb
        sub eax, 32
        stosb
     loop L1
     mov str2[lengthof str2 - 1], 0
    mov edx ,offset str2
    call WriteString
        exit
main endp
end main
```



### Copy an array of 5 doublewords [10, 20, 30, 40, 50] to a destination array in reverse order using MOVSD with std. Print the destination array using WriteDec.

```asm
INCLUDE Irvine32.inc
.data
    arr1 dword 10,20,30,40,50
    arr2 dword lengthof arr1 dup(?)
.code
    main proc
    mov esi ,offset arr1+(lengthof arr1 - 1)* type arr1
    mov edi ,offset arr2+(lengthof arr2 - 1)* type arr2
    mov ecx, lengthof arr1
    std
    rep movsd
    mov esi ,offset arr2
    mov ecx, lengthof arr2
    L1:
    mov eax, dword ptr [esi]
    call WriteDec
    call Crlf
    add esi, type arr2
    loop L1
        exit
main endp
end main
```



### Create two arrays of 10 doublewords. Fill the first with 5555h using STOSD, and the second with 5555h for the first 9 elements and 6666h for the last using STOSD. Use CMPSD to find the first mismatch, then use LODSW and STOSW to copy the remaining elements from the first array to a third array. Print the third array.

```asm
INCLUDE Irvine32.inc
.data
    arr1 dword 10 dup(?)
    arr2 dword 10 dup(?)
    arr3 dword 10 dup(?)
    msg1 byte "array1: ", 0
    msg2 byte "array2: ", 0
    msg3 byte "mismatch found at position: ", 0
    msg4 byte "both arrays are equal", 0
    msg5 byte "array3: ", 0
.code

    printArr proc uses eax esi ecx, arr:ptr dword, arrLen: dword
    mov esi, arr
    mov ecx, arrLen
    L1:
        mov eax, dword ptr [esi]
        call WriteHex
        call Crlf
        add esi, type arr
    loop L1
    ret
    printArr endp

    main proc
    mov eax, 5555h
    mov ecx, lengthof arr1
    mov edi, offset arr1
    cld
    rep stosd

    mov edx, offset msg1
    call WriteString
    call Crlf
    invoke printArr, offset arr1, lengthof arr1

    mov eax, 5555h
    mov ecx, lengthof arr2 - 1
    mov edi, offset arr2
    cld
    rep stosd

    mov eax, 6666h
    mov edi, offset arr2 + (lengthof arr2 - 1)*type arr2
    cld
    stosd

    call Crlf
    mov edx, offset msg2
    call WriteString
    call Crlf

    invoke printArr, offset arr2, lengthof arr2

    mov esi, offset arr1
    mov edi, offset arr2
    cld
    mov ecx, lengthof arr1
    repe cmpsd
    jnz notEqual
    mov edx, offset msg4
    call WriteString
    call Crlf
    jmp exitLabel
    notEqual:
        mov eax, lengthof arr1
        sub eax, ecx
        dec eax
        mov edx, offset msg3
        call Crlf
        call WriteString
        call WriteDec
    copyArr:
       mov esi, offset arr1
       mov edi, offset arr3
       mov ecx, lengthof arr1
       cld
       L1:
       lodsd
       stosd
       loop L1

       call Crlf
       mov edx, offset msg5
       call WriteString
       call Crlf
       
   

       invoke printArr, offset arr3, lengthof arr3
       exitLabel:
        exit
main endp
end main
```
