INCLUDE Irvine32.inc

.data
    sourceArray DWORD 10, 20, 30, 40, 50, 60, 70, 80, 90, 100  ; Array of 10 integers
    destinationArray DWORD 10 DUP (?)  ; Empty array of 10 integers
    msg1 BYTE "Source Array:", 0
    msg2 BYTE "Destination Array:", 0

.code
main:
    ; Initialize stack
    lea eax, sourceArray   ; Load the address of sourceArray into eax

    ; Display message "Source Array"
    mov edx, OFFSET msg1
    call WriteString

    ; Print the source array
    call PrintArray

    ; Push elements from sourceArray onto the stack
    mov ecx, 10            ; Loop counter (for 10 elements)
push_loop:
    mov eax, [eax]         ; Load the current element from sourceArray into eax
    push eax               ; Push the element onto the stack
    add eax, 4             ; Move to the next element in the sourceArray
    loop push_loop         ; Repeat until all elements are pushed onto the stack

    ; Display message "Destination Array"
    mov edx, OFFSET msg2
    call WriteString

    ; Pop elements from the stack into destinationArray
    lea eax, destinationArray ; Load address of destinationArray into eax
    mov ecx, 10            ; Loop counter (for 10 elements)
pop_loop:
    pop eax                ; Pop an element from the stack into eax
    mov [eax], eax         ; Store the popped value into destinationArray
    add eax, 4             ; Move to the next location in destinationArray
    loop pop_loop          ; Repeat until all elements are popped into destinationArray

    ; Display the destination array
    call PrintArray

    ; Exit the program
    exit

PrintArray PROC
    ; Display elements of destination array
    lea eax, destinationArray
    mov ecx, 10
print_loop:
    mov edx, [eax]
    call WriteInt          ; Print the current number
    call Crlf              ; New line after each number
    add eax, 4             ; Move to the next element in the array
    loop print_loop
    ret
PrintArray ENDP

END main
