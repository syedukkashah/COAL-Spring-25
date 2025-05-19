# **Calculating Modulo (a % n) in x86 Assembly (MASM/Irvine32)**

Modulo (remainder after division) is a fundamental operation in assembly. Here's how to compute it efficiently for any divisor `n`.

---

## **📌 Method 1: Using `DIV` or `IDIV`**
The simplest way is to use the `DIV` (unsigned) or `IDIV` (signed) instruction, which stores the **remainder in `EDX`**.

### **Syntax:**
```asm
mov eax, dividend  ; Number to divide
mov ebx, n         ; Divisor
xor edx, edx       ; Clear EDX (for unsigned DIV)
div ebx            ; EAX = quotient, EDX = remainder (mod result)
```

### **Example: Compute `17 % 5`**
```asm
mov eax, 17        ; Dividend
mov ebx, 5         ; Divisor
xor edx, edx       ; Clear EDX (required for DIV)
div ebx            ; EDX = 2 (17 % 5)
; Now, EDX contains the result (2)
```

### **Signed Modulo (`IDIV`)**
```asm
mov eax, -17       ; Signed dividend
mov ebx, 5         ; Divisor
cdq                ; Sign-extend EAX into EDX:EAX
idiv ebx           ; EDX = -2 (-17 % 5)
```

---

## **📌 Method 2: Avoiding Division (For Constant Divisors)**
If `n` is a **power of 2**, use bitwise `AND` for faster modulo:
```asm
mov eax, 17        ; Compute 17 % 8
and eax, 7         ; EAX = 1 (since 8 is 2^3, mask is 7)
```

---

## **📌 Method 3: Handling Edge Cases**
### **Case 1: Modulo by Zero**
Check if `n = 0` before division:
```asm
cmp ebx, 0
je  DivisionByZero  ; Handle error
```

### **Case 2: Negative Numbers**
For **signed modulo**, ensure the remainder has the same sign as the dividend:
```asm
mov eax, -17
mov ebx, 5
cdq                ; Sign-extend EAX into EDX:EAX
idiv ebx           ; EDX = -2 (correct signed remainder)
```

---

## **📌 Example: Function to Compute `a % n`**
```asm
INCLUDE Irvine32.inc

.code
main PROC
    mov eax, 17     ; Dividend
    mov ebx, 5      ; Divisor
    call Modulo     ; Result in EDX
    mov eax, edx    ; Copy result to EAX for printing
    call WriteDec   ; Prints "2"
    exit
main ENDP

; Computes EAX % EBX (result in EDX)
Modulo PROC
    xor edx, edx    ; Clear EDX (for unsigned DIV)
    div ebx         ; EDX = remainder
    ret
Modulo ENDP

END main
```

---

## **📌 Key Notes**
1. **`DIV` vs `IDIV`:**  
   - `DIV` = Unsigned division (clears `EDX` first).  
   - `IDIV` = Signed division (use `cdq` to sign-extend).  
2. **Result Location:**  
   - **Quotient** → `EAX`  
   - **Remainder (mod)** → `EDX`  
3. **Performance:**  
   - Division is slow. Use bitwise tricks if `n` is a power of 2.  

---

## **📌 FAQ**
### **Q: How to compute `a % n` where `n` is a variable?**
```asm
mov ebx, n  ; Divisor can be a register or memory
div ebx     ; EDX = a % n
```

### **Q: What if `n` is 0?**
- **Crash!** Always check:
  ```asm
  cmp ebx, 0
  je  HandleError
  ```

### **Q: How to get modulo of a 64-bit number?**
- Use `DIV` with `EDX:EAX` as the dividend:
  ```asm
  mov edx, highDword
  mov eax, lowDword
  div ebx     ; EDX = remainder
  ```

---

## **🎯 Summary**
| **Method**       | **Usage**                     | **Example**               |
|------------------|-------------------------------|---------------------------|
| `DIV`/`IDIV`     | General case (`n` any number) | `DIV EBX` → `EDX = a % n` |
| Bitmask (`AND`)  | `n` is power of 2             | `AND EAX, 7` for `% 8`    |
| Custom Algorithm | Optimized for specific `n`    | See [libdivide](https://libdivide.com) |
