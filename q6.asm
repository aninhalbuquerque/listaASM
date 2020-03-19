org 0x7c00 
jmp 0x0000:start

data:
    b db "basquete", 0
    f db "futebol", 0
    v db "volei", 0
    r db "rugby", 0
    a db "artes marciais", 0
    nada db "---", 0
    espaco db " | ", 0
    primeiro db "0", 0
    segundo db "0", 0
    terceiro db "0", 0
start:
    mov AX, 0011h       ;modo video
    mov bh, 0
	mov bl, 5
	int 10h
    jmp printStates
looping:
    call lerChar ;ler letra
    mov cl, al
    call printChar
    call lerChar ;ler virgula
    call printChar
    call lerChar ;ler numero
    mov ch, al
    ;sub ch, '0'
    call printChar
    ;call lerChar ;ler \n
    mov ah, 02h         ;colocando o cursor na próxima linha
    mov bh, 0
    add dh, 1
    mov dl, 0
    int 10h
    sub ch, '0'
    cmp ch, 1
        je um
    cmp ch, 2
        je dois
    cmp ch, 3
        je tres
um:
    mov si, primeiro
    lodsb
    cmp al, '0'
        je .soBota
        jne .ajeita

    .soBota:
        mov di, primeiro
        mov al, cl
        stosb
        jmp printStates
    .ajeita:
        mov si, segundo
        lodsb
        mov di, terceiro
        stosb
        mov si, primeiro
        lodsb
        mov di, segundo
        stosb
        mov al, cl
        mov di, primeiro
        stosb
        jmp printStates
dois:
    mov si, segundo
    lodsb
    cmp al, '0'
        je .soBota
        jne .ajeita

    .soBota:
        mov di, segundo
        mov al, cl
        stosb
        jmp printStates
    .ajeita:
        mov si, segundo
        lodsb
        mov di, terceiro
        stosb
        mov al, cl
        mov di, segundo
        stosb
        jmp printStates
tres:
    mov di, terceiro
    mov al, cl
    stosb
    jmp printStates
printStates:
    mov si, terceiro
    lodsb
    call printState3
    mov si, espaco
    call printString
    mov si, primeiro
    lodsb
    call printState1
    mov si, espaco
    call printString
    mov si, segundo
    lodsb
    call printState2
    mov ah, 02h         ;colocando o cursor na próxima linha
    mov bh, 0
    add dh, 1
    mov dl, 0
    int 10h
    jmp looping
printState3:
    cmp al, '0'
        je .n
    cmp al, 'a'
        je .a 
    cmp al, 'b'
        je .b 
    cmp al, 'f' 
        je .f
    cmp al, 'v'
        je .v 
    cmp al, 'r'
        je .r
    .n:
        mov si, nada
        call printString
        ret
    .a:
        mov si, a
        call printString
        ret
    .b: 
        mov si, b
        call printString
        ret
    .f:
        mov si, f
        call printString
        ret
    .v:
        mov si, v
        call printString
        ret
    .r:
        mov si, r 
        call printString
        ret
printState1:
    cmp al, '0'
        je .n
    cmp al, 'a'
        je .a 
    cmp al, 'b'
        je .b 
    cmp al, 'f' 
        je .f
    cmp al, 'v'
        je .v 
    cmp al, 'r'
        je .r
    .n:
        mov si, nada
        call printString
        ret
    .a:
        mov si, a
        call printString
        ret
    .b: 
        mov si, b
        call printString
        ret
    .f:
        mov si, f
        call printString
        ret
    .v:
        mov si, v
        call printString
        ret
    .r:
        mov si, r 
        call printString
        ret
printState2:
    cmp al, '0'
        je .n
    cmp al, 'a'
        je .a 
    cmp al, 'b'
        je .b 
    cmp al, 'f' 
        je .f
    cmp al, 'v'
        je .v 
    cmp al, 'r'
        je .r
    .n:
        mov si, nada
        call printString
        ret
    .a:
        mov si, a
        call printString
        ret
    .b: 
        mov si, b
        call printString
        ret
    .f:
        mov si, f
        call printString
        ret
    .v:
        mov si, v
        call printString
        ret
    .r:
        mov si, r 
        call printString
        ret
printChar:
    mov ah, 0xe
    int 10h
    ret
printString:
    lodsb
    cmp al, 0
        je .fin
    call printChar
    jmp printString
    .fin:
        ret
lerChar:
    mov ah, 0x00
    int 16h
    ret
fim:    
    jmp $
times 510 - ($ - $$) db 0
dw 0xaa55
