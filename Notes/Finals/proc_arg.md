### Write a program that defines a global DWORD variable in the .data section, creates a procedure to print its value using WriteDec, and calls the procedure from main using INVOKE. Use ADDR to pass the variable’s address.
```asm
include Irvine32.inc

.code
PrintValue PROC, pValue:PTR DWORD
    push eax ; push eax to save current value
    mov eax, pValue  ; retrieve address 
    mov eax, [eax] ; de reference address to get value 
    call WriteDec
    call Crlf
    pop eax
    ret
PrintValue ENDP

ProcWithLocalVar PROC
    LOCAL localVar:DWORD ; define a local variable of dword type
    mov localVar, 42 
    INVOKE PrintValue, ADDR localVar ; pass address of local var as argument
    ret
ProcWithLocalVar ENDP

main PROC
    call ProcWithLocalVar
    exit
main ENDP
END main
```
### When local var isn't of dword type

```asm
INCLUDE Irvine32.inc

.code
	func2 proc, x: ptr byte 
		mov esi, x ; load address into esi 
		movzx eax, byte ptr [esi]
		call WriteDec
		call Crlf
		ret
	func2 endp
		
	func1 proc
		local var:byte
		mov var, 5
		invoke func2, addr var 
		ret
	func1 endp

	main proc
	call func1
	exit
	main endp
	END main
```
### using enter and leave 

```asm
INCLUDE Irvine32.inc

.code
	func2 proc, x: ptr byte 
		mov esi, x ; load address into esi 
		movzx eax, byte ptr [esi]
		call WriteDec
		call Crlf
		ret
	func2 endp
		
	func1 proc
		enter 4, 0
		mov byte ptr [ebp-1], 5
		lea edx, [ebp-1] ; lea used for getting address of local var
		invoke func2, edx
		leave
		ret
	func1 endp

	main proc
	call func1
	exit
	main endp
	end main
```

# Understanding `OFFSET` vs `ADDR` vs `LEA` for Getting Addresses in MASM

## Key Differences

|               | `OFFSET`               | `ADDR`                 | `LEA`                  |
|---------------|------------------------|------------------------|------------------------|
| **Works with** | Global variables only  | Local and global vars  | Local and global vars  |
| **When evaluated** | At assembly time    | At assembly time       | At runtime             |
| **Usage context** | Direct code        | Only with `INVOKE`     | Direct code            |
| **Efficiency** | Very efficient        | Efficient              | Slightly less efficient|

## Why You Can't Use `OFFSET` with Local Variables

1. **Local variables don't have fixed addresses** - they're on the stack and their position is only known at runtime
2. **`OFFSET` is resolved during assembly** - the assembler needs to know the exact address when building the executable

```asm
; THIS WON'T WORK:
func PROC
    LOCAL var:DWORD
    mov eax, OFFSET var  ; Error: Cannot use OFFSET with local variable
    ret
func ENDP
```

## When to Use Each

### 1. `ADDR` (Recommended for locals with INVOKE)
```asm
func PROC
    LOCAL var:DWORD
    invoke SomeFunction, ADDR var  ; Correct!
    ret
func ENDP
```

### 2. `LEA` (When not using INVOKE)
```asm
func PROC
    LOCAL var:DWORD
    lea eax, var         ; Correct alternative to ADDR
    push eax
    call SomeFunction
    ret
func ENDP
```

### 3. `OFFSET` (Global variables only)
```asm
.data
globalVar DWORD ?

.code
    mov esi, OFFSET globalVar  ; Correct for globals
```

## What Really Happens with `ADDR`

When you use `ADDR` with a local variable in MASM:
1. The assembler generates `LEA` instructions behind the scenes
2. It automatically handles the stack frame (EBP/ESP relative addressing)

```asm
; What you write:
invoke SomeFunction, ADDR localVar

; What MASM generates (conceptually):
lea eax, [ebp-4]  ; Assuming localVar is at EBP-4
push eax
call SomeFunction
```

## Common Mistakes

1. **Mixing up `OFFSET` and `ADDR`:**
   ```asm
   ; WRONG:
   mov eax, ADDR globalVar  ; ADDR only works with INVOKE
   
   ; RIGHT:
   mov eax, OFFSET globalVar
   ```

2. **Using `OFFSET` with parameters:**
   ```asm
   func PROC param:DWORD
       ; WRONG:
       mov eax, OFFSET param
       
       ; RIGHT:
       lea eax, param
   func ENDP
   ```

## Best Practices

1. Use `ADDR` with `INVOKE` for both local and global variables
2. Use `LEA` when you need the address in normal code
3. Use `OFFSET` only for global/static variables in direct code
4. Never use `OFFSET` with stack-based variables (locals or parameters)

Remember: `ADDR` is essentially MASM's safer, higher-level alternative to `LEA` when using `INVOKE`, while `OFFSET` is only for compile-time-known addresses.
