org 0x7c00
jmp 0x0000:start 
data:
    nTem db "NAO EXISTE", 13, 10, 0
    verd db "VERDE", 13, 10, 0
    amar db "AMARELO", 13, 10, 0
    azul db "AZUL", 13, 10, 0
    verm db "VERMELHO", 13, 10, 0
    enta db 50, 0, 0

start:
    xor ax, ax	;zera ax
	mov ds, ax	;zera ds
	
	mov AX, 0013h
    mov bh, 0
	mov bl, 7
	int 10h

    mov di, enta ;di aponta pro começo da string p/ usar
    call lerString
    mov si, enta ;si aponta pro começo da string
    call contar
    mov si, enta
    call comparaAzul
    mov si, enta
    call comparaVerde
    mov si, enta
    call comparaVermelho
    mov si, enta
    call comparaAmarelo
    jmp naoExiste

lerChar:
    mov ah, 0x00
    int 16h
    ret
printChar:   
    mov ah, 0xe
    int 10h
    ret
lerString:
    mov al, 0
    .for:
        call lerChar ;lê o char e passa o al
        stosb   ;pega o caracter no al e coloca no endereço de memoria ondde di aponta
        call printChar ;printa o caracter
        cmp al, 13 ;chegou no enter?
        je .fim ;cabou string
        jmp .for ;faz dnv
    .fim:
        dec di ;na ultima posição da string tava salvo o enter, aí a gente vai colocar o 0 no lugar
        mov al, 0
        stosb
        ret
contar:
    .for:
        lodsb
        cmp al, 0
        je .endloop
        mov al, ' '
        call printChar
        jmp .for
    .endloop:
        mov al, 13
        call printChar
        ret
comparaVermelho:
    lodsb
    cmp al, 'v'
    jne .errou
    lodsb
    cmp al, 'e'
    jne .errou
    lodsb
    cmp al, 'r'
    jne .errou
    lodsb
    cmp al, 'm'
    jne .errou
    lodsb
    cmp al, 'e'
    jne .errou
    lodsb
    cmp al, 'l'
    jne .errou
    lodsb
    cmp al, 'h'
    jne .errou
    lodsb
    cmp al, 'o'
    jne .errou
    lodsb
    cmp al, 0
    je .vermelho

    .errou:
        ret
    .vermelho:
        mov si, verm
        mov bl, 4
        jmp printaString2
        jmp finalizar
    ret
comparaAmarelo:
    lodsb
    cmp al, 'a'
    jne .errou
    lodsb
    cmp al, 'm'
    jne .errou
    lodsb
    cmp al, 'a'
    jne .errou
    lodsb
    cmp al, 'r'
    jne .errou
    lodsb
    cmp al, 'e'
    jne .errou
    lodsb
    cmp al, 'l'
    jne .errou
    lodsb
    cmp al, 'o'
    jne .errou
    lodsb
    cmp al, 0
    je .amarelo

    .errou:
        ret
    .amarelo:
        mov si, amar
        mov bl, 14
        jmp printaString2
        jmp finalizar
comparaAzul:
    lodsb
    cmp al, 'a'
    jne .errou
    lodsb
    cmp al, 'z'
    jne .errou
    lodsb
    cmp al, 'u'
    jne .errou
    lodsb
    cmp al, 'l'
    jne .errou
    lodsb
    cmp al, 0
    je .azul

    .errou:
        ret
    .azul:
        mov si, azul
        mov bl, 1
        jmp printaString2 
        jmp finalizar
comparaVerde:
    lodsb
    cmp al, 'v'
    jne .errou
    lodsb
    cmp al, 'e'
    jne .errou
    lodsb
    cmp al, 'r'
    jne .errou
    lodsb
    cmp al, 'd'
    jne .errou
    lodsb
    cmp al, 'e'
    jne .errou
    lodsb
    cmp al, 0
    je .verde

    .errou:
        ret
    .verde:
        mov si, verd
        mov bl, 2
        jmp printaString2
        jmp finalizar
naoExiste: 
    mov si, nTem
    mov bl, 5
    jmp printaString2

printaString2:
    lodsb
    cmp al, 0
        je finalizar
    call printChar
    jmp printaString2
finalizar:
    times 510 - ($ - $$) db 0
    dw 0xaa55
