INCLUDE Irvine32.inc

.data
    prompt1  BYTE "Enter the first integer: ", 0
    prompt2  BYTE "Enter the second integer: ", 0
    prompt3  BYTE "Enter the third integer: ", 0
    resultMsg BYTE "The sum is: ", 0

.code
main:
    ; Prompt for and read the first integer
    mov edx, OFFSET prompt1
    call WriteString
    call ReadInt
    push eax          ; Push the first integer onto the stack

    ; Prompt for and read the second integer
    mov edx, OFFSET prompt2
    call WriteString
    call ReadInt
    push eax          ; Push the second integer onto the stack

    ; Prompt for and read the third integer
    mov edx, OFFSET prompt3
    call WriteString
    call ReadInt
    push eax          ; Push the third integer onto the stack

    ; Pop the integers off the stack and add them
    pop eax           ; Pop the third integer into eax
    mov ebx, eax      ; Store it in ebx temporarily

    pop eax           ; Pop the second integer into eax
    add eax, ebx      ; Add the second and third integers

    pop ebx           ; Pop the first integer into ebx
    add eax, ebx      ; Add the first integer to the sum

    ; Display the result
    mov edx, OFFSET resultMsg
    call WriteString
    call WriteInt     ; Display the sum in eax

    ; Exit the program
    exit
end main
