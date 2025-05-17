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
