section .data
    inputBuf db 0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A
    inputBufLen equ 8
    space db ' '

section .bss
    outputBuf resb 80

section .text
global _start

_start:
    mov esi, inputBuf        ; Source index: point to start of inputBuf
    mov edi, outputBuf       ; Destination index: point to start of outputBuf
    mov ecx, inputBufLen     ; Counter: number of bytes to process

.loop:
    movzx eax, byte [esi]    ; Get the current byte
    
    
    mov edx, eax
    shr edx, 4               ; Shift right by 4 to get the left digit i.e. 0x83 gets 8
    call convert_to_ascii
    mov [edi], dl
    inc edi

    
    mov edx, eax
    and edx, 0x0F            ; Mask to get the right digit 
    call convert_to_ascii
    mov [edi], dl
    inc edi

    ; Add a space, except for the last byte
    dec ecx
    jz .print                ; If it's the last byte, skip adding space
    mov byte [edi], ' '
    inc edi

    ; Move to next byte
    inc esi
    jmp .loop

.print:
    ; Print the result
    mov eax, 4               ; sys_write
    mov ebx, 1               ; stdout
    mov ecx, outputBuf       ; buffer to write
    mov edx, edi             ; number of bytes to write
    sub edx, outputBuf       ; calculate the length
    int 0x80

    ; Exit
    mov eax, 1               ; sys_exit
    xor ebx, ebx             ; exit code 0
    int 0x80

convert_to_ascii:
    cmp dl, 10
    jl .digit
    add dl, 'A' - 10
    ret
.digit:
    add dl, '0'
    ret
