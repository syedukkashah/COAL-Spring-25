To check if a number is even (divisible by 2) in MASM x86 assembly using the Irvine32 library, you can use the modulo operation and compare the remainder. The equivalent of the C-style condition `num % 2 == 0` 

### Explanation
- The number to check (`num`) is stored in a register or memory.
- Use the `DIV` instruction to divide `num` by 2. The remainder is stored in the `EDX` register.
- Compare the remainder (`EDX`) to 0 to determine if the number is even.
- If the remainder is 0, execute the "do something" code (e.g., print a message).

### Assumptions
- The number `num` is a 32-bit integer stored in a variable or register.
- The Irvine32 library is included for simplified I/O operations (e.g., `WriteString` or `WriteInt`).
- The "do something" part will be a simple action like printing a message.

### Example Code
```asm
INCLUDE Irvine32.inc

.data
num      DWORD 10          ; Example number to check (change to test other numbers)
evenMsg  BYTE "Number is even", 0
oddMsg   BYTE "Number is odd", 0

.code
main PROC
    ; Load the number into EAX
    mov eax, num           ; EAX = num

    ; Divide EAX by 2
    mov ebx, 2             ; Divisor = 2
    xor edx, edx           ; Clear EDX (will hold remainder)
    div ebx                ; EAX = quotient, EDX = remainder

    ; Check if remainder (EDX) is 0
    cmp edx, 0             ; Compare remainder with 0
    je isEven              ; Jump to isEven if remainder == 0

    ; If odd (remainder != 0)
    mov edx, OFFSET oddMsg ; Load address of odd message
    call WriteString       ; Print odd message
    jmp done               ; Jump to end

isEven:
    ; If even (remainder == 0)
    mov edx, OFFSET evenMsg; Load address of even message
    call WriteString       ; Print even message

done:
    call Crlf              ; Print newline
    exit                   ; Exit program

main ENDP
END main
```

### Step-by-Step Breakdown
1. **Setup**:
   - The Irvine32 library is included for I/O functions like `WriteString`.
   - `num` is a 32-bit integer (e.g., 10). You can change this value to test other numbers.
   - Two strings (`evenMsg` and `oddMsg`) are defined for output.

2. **Load the Number**:
   - `mov eax, num` loads the number into `EAX` for division.

3. **Perform Division**:
   - `mov ebx, 2` sets the divisor to 2.
   - `xor edx, edx` clears `EDX` because the `DIV` instruction uses `EDX:EAX` as the dividend.
   - `div ebx` divides `EDX:EAX` by `EBX` (2). The quotient goes to `EAX`, and the remainder goes to `EDX`.

4. **Check Remainder**:
   - `cmp edx, 0` compares the remainder (`EDX`) to 0.
   - `je isEven` jumps to the `isEven` label if the remainder is 0 (i.e., the number is even).

5. **Handle Even/Odd**:
   - If the number is odd (`EDX != 0`), print the odd message using `WriteString`.
   - If the number is even (`EDX == 0`), jump to `isEven` and print the even message.

6. **Exit**:
   - `call Crlf` prints a newline for clean output.
   - `exit` terminates the program (Irvine32 macro).

### Testing
- If `num = 10`, the program prints: `Number is even`.
- If `num = 7`, the program prints: `Number is odd`.

### Notes
- **Irvine32**: The `WriteString` and `Crlf` procedures require the Irvine32 library. Ensure it’s properly linked during compilation.
- **Register Usage**: Be cautious with `EAX`, `EBX`, and `EDX`, as `DIV` modifies them. Save/restore other registers if needed in a larger program.
- **Input**: To make the program interactive, you can use `ReadInt` from Irvine32 to get `num` from the user. Replace `mov eax, num` with `call ReadInt` (stores input in `EAX`).
- **Signed Numbers**: The example assumes `num` is unsigned. For signed numbers, use `CDQ` before `IDIV` instead of `xor edx, edx` and `DIV`.

### How to Run
1. Use an assembler like MASM with Visual Studio or a standalone MASM setup.
2. Link with the Irvine32 library (ensure `Irvine32.lib` is in your project).
3. Assemble, link, and run the program.

If you need a version with user input or have specific "do something" code, let me know, and I can modify the example!
