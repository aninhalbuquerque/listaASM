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
    call printChar
    ;call lerChar ;ler \n
    call pularLinha
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
    cmp al, cl          ;se o que eu botei agora já ta na posição 1
        je printStates 
    mov si, segundo     ;se o que eu botei agora ta no 2
    lodsb
    cmp al, cl
        je .taNo2
    mov si, terceiro     ;se o que eu botei agora ta no 2
    lodsb
    cmp al, cl
        je .ajeita
    mov si, primeiro
    lodsb
    cmp al, '0'
        je .soBota
        jne .ajeita
    .taNo2:
        call mudar21
        call escreve1
        jmp printStates
    .soBota:
        call escreve1
        jmp printStates
    .ajeita:
        call mudar32
        call mudar21
        call escreve1
        jmp printStates
dois:
    mov si, segundo
    lodsb
    cmp al, cl
        je printStates
    mov si, primeiro 
    lodsb
    cmp al, cl
        je .taNo1
    mov si, terceiro
        je .ajeita
    mov si, segundo
    lodsb
    cmp al, '0'
        je .soBota
        jne .ajeita

    .taNo1:
        call mudar12
        call escreve2
        jmp printStates
    .soBota:
        call escreve2
        jmp printStates
    .ajeita:
        call mudar32
        call escreve2
        jmp printStates
tres:
    mov si, terceiro
    lodsb
    cmp al, cl
        je printStates
    mov si, segundo
    lodsb
    cmp al, cl
        je .taNo2
    mov si, primeiro
    lodsb
    cmp al, cl
        je .taNo1
    
    call escreve3
    jmp printStates

    .taNo2:
        call mudar23
        call escreve3
        jmp printStates
    .taNo1:
        call mudar12
        call mudar23
        call escreve3
        jmp printStates

mudar12:
    mov si, segundo
    lodsb
    mov di, primeiro
    stosb
    ret
mudar21:
    mov si, primeiro
    lodsb
    mov di, segundo
    stosb
    ret
mudar23:
    mov si, terceiro
    lodsb
    mov di, segundo
    stosb
    ret
mudar32:
    mov si, segundo
    lodsb
    mov di, terceiro
    stosb
    ret
escreve1:
    mov di, primeiro
    mov al, cl
    stosb
    ret
escreve2:
    mov di, segundo
    mov al, cl
    stosb
    ret
escreve3:
    mov di, terceiro
    mov al, cl
    stosb
    ret
printStates:
    mov si, terceiro
    lodsb
    call printState
    mov si, espaco
    call printString
    mov si, primeiro
    lodsb
    call printState
    mov si, espaco
    call printString
    mov si, segundo
    lodsb
    call printState
    call pularLinha
    jmp looping
printState:
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
pularLinha:
    mov ah, 02h         ;colocando o cursor na próxima linha
    mov bh, 0
    add dh, 1
    mov dl, 0
    int 10h
    ret
fim:    
    jmp $
times 510 - ($ - $$) db 0
dw 0xaa55
