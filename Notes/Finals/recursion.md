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

### FACTORIAL
```asm
INCLUDE Irvine32.inc
.data
	n dword 5
	res dword ?
.code
	factorial proc, fact:dword
	cmp fact, 0
	je L1
	mov eax, fact ;copy current val
	dec eax ;fact-1
	push eax ;save for multiplication later
	invoke factorial, eax
	pop ebx ; get saved (fact-1) value
	mul ebx ; eax*=ebx
	ret
	L1: mov eax, 1
	ret
	factorial endp

	main proc
	invoke factorial, n
	mov res, eax
	call WriteDec
	exit
	main endp
	end main
```

### **Control Flow Explanation for the Recursive Factorial Program**

This program calculates the factorial of a number (`n = 5`) using **recursion**. Below is a step-by-step breakdown of how the control flows and when the multiplication happens.

---

## **Key Concepts**
1. **Recursion**: The function calls itself with a smaller input (`fact-1`).
2. **Stack Usage**: Each recursive call saves the current value of `fact` on the stack before proceeding.
3. **Base Case Termination**: When `fact ≤ 1`, recursion stops, and multiplication begins on the way back up.

---

## **Step-by-Step Execution for `factorial(5)`**
### **Initial Call (fact = 5)**
1. **Check Base Case**:  
   - `cmp fact, 1` → `5 > 1`, so recursion continues.
2. **Prepare for Recursion**:
   - `mov eax, fact` → `eax = 5`  
   - `dec eax` → `eax = 4`  
   - `push eax` → **Save `4` on the stack** (needed later for multiplication).  
3. **Recursive Call**:
   - `invoke factorial, 4` → **Calls `factorial(4)`** (program jumps back to start).

---

### **Recursive Call (fact = 4)**
1. **Check Base Case**:  
   - `4 > 1`, so recursion continues.
2. **Prepare for Recursion**:
   - `mov eax, 4`  
   - `dec eax` → `eax = 3`  
   - `push eax` → **Save `3` on the stack**.  
3. **Recursive Call**:
   - `invoke factorial, 3` → **Calls `factorial(3)`**.

---

### **Recursive Call (fact = 3)**
1. **Check Base Case**:  
   - `3 > 1`, recursion continues.
2. **Prepare for Recursion**:
   - `mov eax, 3`  
   - `dec eax` → `eax = 2`  
   - `push eax` → **Save `2` on the stack**.  
3. **Recursive Call**:
   - `invoke factorial, 2` → **Calls `factorial(2)`**.

---

### **Recursive Call (fact = 2)**
1. **Check Base Case**:  
   - `2 > 1`, recursion continues.
2. **Prepare for Recursion**:
   - `mov eax, 2`  
   - `dec eax` → `eax = 1`  
   - `push eax` → **Save `1` on the stack**.  
3. **Recursive Call**:
   - `invoke factorial, 1` → **Calls `factorial(1)`**.

---

### **Base Case Reached (fact = 1)**
1. **Check Base Case**:  
   - `1 == 1`, so **base case triggers**.
2. **Return 1**:
   - `mov eax, 1` → Sets return value (`eax = 1`).
   - `ret` → **Returns to the previous call (`factorial(2)`)**.

---

## **Now, the Multiplication Phase Begins (Unwinding the Stack)**
### **Returning to `factorial(2)`**
1. **After `invoke factorial, 1` returns (`eax = 1`)**:
   - `pop ebx` → **Restores `1` from the stack into `ebx`**.
   - `mul ebx` → `eax = eax * ebx` → `1 * 1 = 1` (result stored in `eax`).
   - `ret` → **Returns to `factorial(3)`**.

---

### **Returning to `factorial(3)`**
1. **After `invoke factorial, 2` returns (`eax = 2`)**:
   - `pop ebx` → **Restores `2` from the stack into `ebx`**.
   - `mul ebx` → `2 * 2 = 4` (result in `eax`).
   - `ret` → **Returns to `factorial(4)`**.

---

### **Returning to `factorial(4)`**
1. **After `invoke factorial, 3` returns (`eax = 6`)**:
   - `pop ebx` → **Restores `3` from the stack into `ebx`**.
   - `mul ebx` → `6 * 3 = 18` (result in `eax`).
   - `ret` → **Returns to `factorial(5)`**.

---

### **Final Return to `factorial(5)`**
1. **After `invoke factorial, 4` returns (`eax = 24`)**:
   - `pop ebx` → **Restores `4` from the stack into `ebx`**.
   - `mul ebx` → `24 * 4 = 120` (final result in `eax`).
   - `ret` → **Returns to `main`**.

---

## **Final Output**
- The result (`120`) is stored in `eax` and printed using `WriteDec`.

---

## **Summary of Control Flow**
1. **Recursive Descent**:
   - Each call pushes the current `fact-1` onto the stack.
   - Continues until `fact = 1` (base case).

2. **Multiplication Phase (Unwinding)**:
   - After the base case returns, each recursive call:
     - Pops the saved value (`fact-1`) from the stack.
     - Multiplies it with the returned value (`eax`).
   - Continues until the original call (`factorial(5)`) computes the final result.

---

### **Key Takeaways**
✔ **Recursion works by breaking the problem into smaller subproblems.**  
✔ **The multiplication happens only after the deepest call (`factorial(1)`) returns.**  
✔ **The stack is used to store intermediate values for later computation.**  
✔ **The final result accumulates as the recursion unwinds.**  


# **Recursion in x86 Assembly (MASM/Irvine32)**

Recursion in assembly follows the same principles as high-level languages:  
1. A **base case** (stopping condition).  
2. A **recursive call** (function calls itself with modified arguments).  
3. **Stack management** (saving/restoring registers and local state).  

---

## **📌 Key Concepts for Recursion in Assembly**
1. **Use the stack** to preserve:  
   - **Return addresses** (handled by `CALL`/`RET`).  
   - **Parameters** (passed via stack or registers).  
   - **Local variables** (if needed).  
2. **Avoid register corruption** (use `PUSH`/`POP` or `USES`).  
3. **Tail recursion** (optimizable) vs **non-tail recursion** (requires stack storage).  

---

## **📝 Example 1: Factorial (Non-Tail Recursive)**
Calculates `n!` using recursion.  
```asm
INCLUDE Irvine32.inc

.code
main PROC
    mov  eax, 5           ; Compute 5!
    call Factorial        ; Result in EAX
    call WriteDec         ; Output: 120
    exit
main ENDP

; Recursive factorial function
Factorial PROC
    ; Base case: if n <= 1, return 1
    cmp  eax, 1
    jle  BaseCase

    ; Recursive case: n * Factorial(n-1)
    push eax              ; Save current n
    dec  eax              ; n = n-1
    call Factorial        ; EAX = Factorial(n-1)
    pop  ebx              ; Restore original n (now in EBX)
    mul  ebx              ; EAX = EAX * EBX
    ret

BaseCase:
    mov  eax, 1           ; Return 1
    ret
Factorial ENDP

END main
```

### **How It Works:**
1. **Base Case:** If `n ≤ 1`, return `1`.  
2. **Recursive Case:**  
   - `PUSH EAX` saves `n` on the stack.  
   - `DEC EAX` prepares `n-1` for the next call.  
   - After recursion, `POP EBX` restores `n`, then `MUL EBX` computes `n * Factorial(n-1)`.  

---

## **📝 Example 2: Fibonacci Sequence**
Computes `Fib(n)` where `Fib(0)=0`, `Fib(1)=1`, `Fib(n)=Fib(n-1)+Fib(n-2)`.  
```asm
INCLUDE Irvine32.inc

.code
main PROC
    mov  eax, 7           ; Compute Fib(7)
    call Fibonacci        ; Result in EAX
    call WriteDec         ; Output: 13
    exit
main ENDP

Fibonacci PROC
    ; Base cases: Fib(0)=0, Fib(1)=1
    cmp  eax, 0
    je   Return0
    cmp  eax, 1
    je   Return1

    ; Recursive case: Fib(n-1) + Fib(n-2)
    push eax              ; Save n
    dec  eax              ; n-1
    call Fibonacci        ; EAX = Fib(n-1)
    push eax              ; Save Fib(n-1)
    dec  dword ptr [esp+4] ; Original n → n-2
    call Fibonacci        ; EAX = Fib(n-2)
    pop  ebx              ; EBX = Fib(n-1)
    add  eax, ebx         ; EAX = Fib(n-1) + Fib(n-2)
    pop  ecx              ; Cleanup stack (discard original n)
    ret

Return0:
    mov  eax, 0
    ret
Return1:
    mov  eax, 1
    ret
Fibonacci ENDP

END main
```

### **How It Works:**
1. **Base Cases:** `Fib(0)=0`, `Fib(1)=1`.  
2. **Recursive Case:**  
   - Compute `Fib(n-1)` first (saving `n` and the result).  
   - Compute `Fib(n-2)` using the original `n` (adjusted on the stack).  
   - Sum the results (`EAX = Fib(n-1) + Fib(n-2)`).  

---

## **📝 Example 3: Tail-Recursive Sum (Optimizable)**
Computes the sum of numbers from `n` to `1` (tail recursion avoids stack growth).  
```asm
INCLUDE Irvine32.inc

.code
main PROC
    mov  eax, 5           ; Sum from 5 to 1
    mov  ebx, 0           ; Accumulator (starts at 0)
    call SumToN           ; Result in EAX
    call WriteDec         ; Output: 15 (5+4+3+2+1)
    exit
main ENDP

; Tail-recursive sum (optimizable to a loop)
SumToN PROC
    ; Base case: if n == 0, return accumulator (EBX)
    cmp  eax, 0
    je   ReturnAcc

    ; Recursive case: SumToN(n-1, acc + n)
    add  ebx, eax         ; acc += n
    dec  eax              ; n = n-1
    jmp  SumToN           ; Tail call (no stack growth)

ReturnAcc:
    mov  eax, ebx         ; Return accumulator
    ret
SumToN ENDP

END main
```

### **How It Works:**
1. **Tail recursion** replaces `CALL` with `JMP`, avoiding stack growth.  
2. **Accumulator (`EBX`)** stores intermediate results.  
3. **Optimization:** A smart assembler could convert this into a loop.  

---

## **📌 Key Takeaways**
1. **Base Case:** Always define a stopping condition.  
2. **Stack Management:**  
   - Use `PUSH`/`POP` to save/restore registers.  
   - `CALL` automatically pushes the return address.  
3. **Tail Recursion:** More efficient (can be optimized into a loop).  
4. **Debugging:** Use **OllyDbg** or **Visual Studio Debugger** to trace the stack.  

Would you like an example with **local variables** or **mixed recursion/iteration**? 😊
