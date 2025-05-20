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


# **Mastering `MUL`, `IMUL`, `DIV`, `IDIV`, `ADC`, `SBB` in x86 Assembly (MASM/Irvine32)**

These instructions are crucial for arithmetic operations in assembly. Let’s break them down with **clear examples** and **key insights** before your exam!  

---

## **1️⃣ `MUL` (Unsigned Multiplication)**
### **Syntax:**
```asm
MUL reg/mem   ; Multiplies by AL/AX/EAX
```
### **Behavior:**
- **8-bit:** `AL * operand` → Result in `AX`  
- **16-bit:** `AX * operand` → Result in `DX:AX`  
- **32-bit:** `EAX * operand` → Result in `EDX:EAX`  

### **Example: Multiply 5 × 3**
```asm
mov al, 5      ; AL = 5
mov bl, 3      ; BL = 3
mul bl         ; AX = AL * BL = 15
```

### **Key Points:**
- Always clears `EDX`/`DX` before use (for 16/32-bit).  
- **Overflow:** If the result exceeds the register size, the higher bits go into `DX`/`EDX`.

---

## **2️⃣ `IMUL` (Signed Multiplication)**
### **Syntax (3 Forms):**
```asm
IMUL reg/mem                     ; Single-operand (like MUL, but signed)
IMUL dest, src                   ; dest = dest * src
IMUL dest, src, immediate        ; dest = src * immediate
```
### **Example: Multiply (-5) × 3**
```asm
mov al, -5     ; AL = -5 (signed)
mov bl, 3      ; BL = 3
imul bl        ; AX = -15
```

### **Example: 3-Operand Form**
```asm
imul eax, ebx, 10   ; EAX = EBX * 10
```

### **Key Points:**
- **Overflow:** Unlike `MUL`, `IMUL` truncates results (no `DX:AX` output for multi-operand forms).  
- **Sign matters:** `FFh` = `-1` (signed) vs `255` (unsigned).

---

## **3️⃣ `DIV` (Unsigned Division)**
### **Syntax:**
```asm
DIV reg/mem   ; Divides AX/DX:AX/EDX:EAX by operand
```
### **Behavior:**
- **8-bit:** `AX / operand` → Quotient in `AL`, Remainder in `AH`  
- **16-bit:** `DX:AX / operand` → Quotient in `AX`, Remainder in `DX`  
- **32-bit:** `EDX:EAX / operand` → Quotient in `EAX`, Remainder in `EDX`  

### **Example: Divide 15 by 3**
```asm
mov ax, 15     ; AX = 15
mov bl, 3      ; BL = 3
div bl         ; AL = 5 (quotient), AH = 0 (remainder)
```

### **Key Points:**
- **Must clear `EDX`/`DX` first** (for 16/32-bit division).  
- **Crash if divisor = 0!** Always check:
  ```asm
  cmp bl, 0
  je  DivisionError
  ```

---

## **4️⃣ `IDIV` (Signed Division)**
### **Syntax:**
```asm
IDIV reg/mem   ; Signed version of DIV
```
### **Example: Divide (-15) by 3**
```asm
mov ax, -15    ; AX = -15 (signed)
mov bl, 3      ; BL = 3
idiv bl        ; AL = -5 (quotient), AH = 0 (remainder)
```

### **Key Points:**
- Use `CDQ` (32-bit) or `CWD` (16-bit) to sign-extend `EAX`/`AX` into `EDX`/`DX`.  
- **Same remainder rules as high-level languages:**  
  - `-15 % 4` = `-3` (remainder takes the sign of the dividend).

---

## **5️⃣ `ADC` (Add with Carry)**
### **Syntax:**
```asm
ADC dest, src   ; dest = dest + src + CarryFlag
```
### **Use Case:**  
Multi-precision arithmetic (e.g., 64-bit addition on 32-bit registers).

### **Example: 64-bit Addition**
```asm
mov eax, [num1_low]   ; Low 32 bits of num1
mov ebx, [num2_low]   ; Low 32 bits of num2
add eax, ebx          ; Add low parts (sets CF if overflow)
mov ecx, [num1_high]  ; High 32 bits of num1
mov edx, [num2_high]  ; High 32 bits of num2
adc ecx, edx          ; Add high parts + carry
```

### **Key Points:**
- **`ADC` = `ADD` + Carry Flag.**  
- Used in **big-number arithmetic** (e.g., cryptography).

---

## **6️⃣ `SBB` (Subtract with Borrow)**
### **Syntax:**
```asm
SBB dest, src   ; dest = dest - src - CarryFlag
```
### **Use Case:**  
Multi-precision subtraction (e.g., 64-bit subtraction).

### **Example: 64-bit Subtraction**
```asm
mov eax, [num1_low]   ; Low 32 bits
mov ebx, [num2_low]   ; Low 32 bits
sub eax, ebx          ; Subtract low parts (sets CF if borrow)
mov ecx, [num1_high]  ; High 32 bits
mov edx, [num2_high]  ; High 32 bits
sbb ecx, edx          ; Subtract high parts - borrow
```

### **Key Points:**
- **`SBB` = `SUB` + Borrow Flag.**  
- Essential for **large integer operations**.

---

## **📌 Summary Table**
| Instruction | Purpose                     | Example                     | Key Notes                          |
|-------------|-----------------------------|-----------------------------|------------------------------------|
| `MUL`       | Unsigned multiply           | `mul bl` (AX = AL * BL)     | Result in `DX:AX`/`EDX:EAX`       |
| `IMUL`      | Signed multiply             | `imul eax, ebx, 10`        | Truncates overflow                 |
| `DIV`       | Unsigned division           | `div bl` (AL=quot, AH=rem)  | Clear `EDX` first!                 |
| `IDIV`      | Signed division             | `idiv bl` (AL=-5 if -15/3)  | Use `CDQ`/`CWD` for sign-extension |
| `ADC`       | Add with carry              | `adc ecx, edx` (64-bit add) | Used in big-number math            |
| `SBB`       | Subtract with borrow        | `sbb ecx, edx` (64-bit sub) | Handles borrow like ADC handles CF |

---

## **🔥 Exam Tips**
1. **`DIV`/`IDIV`:** Always check for **division by zero**!  
2. **`MUL` vs `IMUL`:** Remember `MUL` stores high bits in `DX`/`EDX`.  
3. **`ADC`/`SBB`:** Think of them as **`ADD`/`SUB` + Carry Flag**.  
4. **Debugging:** Use **`TEST` + `JZ`** to check for zero before division.  
