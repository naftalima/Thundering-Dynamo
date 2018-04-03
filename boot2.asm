org 0x500
jmp 0x0000:start

nabeluBIOS db 'Starting NabeluBios (version 0.5.2-05002011_040-oxe)',0

loading0 db 'Loading struct for the kernel...', 0
setting db 'Setting up protected mode...', 0
loading1 db 'Loading kernel in memory...', 0
running db 'Running kernel...', 0
press db 'Continue?                                       PRESS ENTER'

inp times 5 db 0;reserva 5 bytes	

start:
    xor ax, ax
    mov ds, ax
    mov es, ax

    mov ax, 0x7e0 ;0x7e0<<1 = 0x7e00 (início de kernel.asm)
    mov es, ax
    xor bx, bx    ;posição es<<1+bx


	;modo de grafico	
	mov ah,0 
	mov al, 12h
	int 10h

	;background
	mov ah,0xb
	mov bh,0
	mov bl, 0 ; color
	int 10h


	;nao sei pra que serve
	;mov ax, 0003h  ;limpa a tela mantendo o modo texto
    	;int 10h

	mov bl,0x2;color
	mov bx, 0
	mov si, nabeluBIOS
	call printer

	call pula

	mov si, loading0
	call printe

	mov si, setting
	call printe

	mov si, loading1
	call printe

	mov si, running
	call printe

	call pula
	call pula

	mov si, press
	call printer
	
	mov di, inp
	call inpute
	


    jmp reset

reset:
    mov ah, 00h ;reseta o controlador de disco
    mov dl, 0   ;floppy disk
    int 13h

    jc reset    ;se o acesso falhar, tenta novamente

    jmp load

load:
    mov ah, 02h ;lê um setor do disco
    mov al, 20  ;quantidade de setores ocupados pelo kernel
    mov ch, 0   ;track 0
    mov cl, 3   ;sector 3
    mov dh, 0   ;head 0
    mov dl, 0   ;drive 0
    int 13h

    jc load     ;se o acesso falhar, tenta novamente

    jmp 0x7e00  ;pula para o setor de endereco 0x7e00 (start do boot2)




;--------------------------
printer:
	lodsb
	cmp al,0
	je doner

	mov ah, 0eh
	mov bl, 0x2 ; define a cor como verde de acordo com o Bios color attributes
	int 10h

	jmp printer

	doner:
		mov ah, 0eh
		mov al, 0xd
		int 10h
		mov al, 0xa
		int 10h
		ret
;------------------------

printe:
	lodsb
	cmp al,0
	je done

	mov ah, 0eh
	mov bl, 0x2
	int 10h

	mov dx, 0
	.delei: ;delay
	inc dx
	mov cx, 0
		.time:
			inc cx
			cmp cx, 10000
			jne .time

	cmp dx, 1000
	jne .delei

	jmp printe

	done:
		mov ah, 0eh
		mov al, 0xd
		int 10h
		mov al, 0xa
		int 10h
		
		ret

;------------------

inpute:
	;loop until stopped condition
	mov ah, 0
	int 16h
	stosb 

	;0xa == /n , Line Feed 
	cmp al, 0xd ; byte value exceeds bounds??
	je .returne
	

	jmp inpute

.returne:
	ret

;--------------------
pula:
	mov ah, 0eh
	mov al, 0xd
	int 10h
	mov al, 0xa
	int 10h
	mov ah, 0eh
	mov al, 0xd
	int 10h
	mov al, 0xa
	int 10h
	ret
		


