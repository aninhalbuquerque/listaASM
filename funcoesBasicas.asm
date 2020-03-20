org 0x7c00 
jmp 0x0000:start

data: ;declaração de string
    string1 db "oie", 13, 10, 0   ;13 -> enter
    string2 db "oie", 0
start:
    call modoVideo
    call lerChar
    call printChar
    jmp fim
multiplicar:
    mul cl      ;multiplica al*cl e salva em al
    ret
dividir:
    div cl      ;divide ax/cl
    ret         ;al = quociente, ah = resto
empilha:
    push ax     ;pega o valor que ta em ax e bota na pilha
    ret
desempilha:
    pop ax      ;tira o topo da pilha e salva e, ax
    ret
modoVideo:
    mov AX, 0011h
    mov bh, 0
	mov bl, 5
	int 10h
    ret
modoVideoCor:
    mov ax, 0013h
    mov bh, 0
	mov bl, 5       ;muda cor
	int 10h
    ret
lerChar:
    mov ah, 0x00
    int 16h
    ret
printChar:   
    mov ah, 0xe
    int 10h
    ret
printString:
    lodsb       ;passa da posição de di da string pra al
    cmp al, 0
        je .fin
    call printChar
    jmp printString
    .fin:
        ret
lerString:
    mov al, 0
    .for:
        call lerChar 
        stosb   ;pega o caracter no al e coloca no endereço de memoria onde di aponta
        call printChar 
        cmp al, 13 ;chegou no enter?
            je .fim ;cabou string
        jmp .for ;faz dnv
    .fim:
        dec di ;na ultima posição da string tava salvo o enter, aí a gente vai colocar o 0 no lugar
        mov al, 0
        stosb
        ret
pularLinha:
    mov ah, 02h
    mov bh, 0
    add dh, 1
    mov dl, 0
    int 10h
    ret
fim:    
    jmp $
times 510 - ($ - $$) db 0
dw 0xaa55
