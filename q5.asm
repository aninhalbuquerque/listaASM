org 0x7c00 
jmp 0x0000:start

data:
    a db "0", 0
    b db "0", 0
    c db "0", 0
    d db "0", 0
    num db "aaaaa", 0
    den db "aaaaa", 0
start:
    mov AX, 0011h       ;modo video
    mov bh, 0
	mov bl, 5
	int 10h

    call lerNumeros

    mov ah, 02h         ;colocando o cursor na próxima linha
    mov bh, 0
    add dh, 1
    mov dl, 0
    int 10h

    call multiAD        ;multiplica a*d e salva em cl
    call multiCB        ;multiplica c*b e salva em ch

    mov al, cl
    add al, ch
    mov ah, 0
    mov di, num
    mov cl, 10
    call calNum         ;vai salvar o numerador ao contrario

    mov si, num
    add si, 4
    call printNum     ;printa numerador

    mov al, '/'
    call printChar

    call multiBD        ;multiplica b*d e salva em al
    mov ah, 0
    mov di, den
    mov cl, 10
    call calNum

    mov si, den
    add si, 4
    call printDen

    jmp fim
multiAD:
    mov si, a
    lodsb
    mov cl, al
    mov si, d
    lodsb
    mul cl
    mov cl, al
    ;add al, '0'
    ;call printChar
    ret
multiCB:
    mov si, b
    lodsb
    mov ch, al
    mov si, c
    lodsb
    mul ch
    mov ch, al
    ret
multiBD:
    mov si, b
    lodsb
    mov ch, al
    mov si, d
    lodsb
    mul ch
    mov ch, al
    ret
calNum:
    mov ah, 0
    div cl     ;al = quociente, ah = resto
    mov dl, al
    mov al, ah  ;dl = quociente, al = resto
    stosb

    ;add al, '0'
    ;call printChar

    mov al, dl  ;quociente volta pra al pra continuar dividindo  

    cmp al, 0
        je .fin
    jmp calNum
    .fin:
        ret

lerNumeros:
    call lerChar ;ler a
    call printChar
    sub al, '0'
    mov di, a
    stosb
    call lerChar ;ler /
    call printChar
    call lerChar ;ler b
    call printChar
    sub al, '0'
    mov di, b
    stosb
    call lerChar ;ler espaco
    call printChar
    call lerChar ;ler c
    call printChar
    sub al, '0'
    mov di, c
    stosb
    call lerChar ;ler /
    call printChar
    call lerChar ;ler d
    call printChar
    sub al, '0'
    mov di, d
    stosb
    call lerChar ;ler /n
    call printChar
    ret
printChar:
    mov ah, 0xe
    int 10h
    ret
lerChar:
    mov ah, 0x00
    int 16h
    ret
printNum:
    lodsb
    cmp al, 'a'
        je .cont
        jne .print

    .cont:
        sub si, 2
        jmp printNum
    .print:
        cmp si, num
            je .fin
        add al, '0'
        call printChar
        sub si, 2
        jmp printNum
    
    .fin:
        ret
printDen:
    lodsb
    cmp al, 'a'
        je .cont
        jne .print

    .cont:
        sub si, 2
        jmp printDen
    .print:
        cmp si, den
            je .fin
        add al, '0'
        call printChar
        sub si, 2
        jmp printDen
    
    .fin:
        ret
fim:    
    jmp $
times 510 - ($ - $$) db 0
dw 0xaa55
