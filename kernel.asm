org 0x7e00
jmp 0x0000:start

  
;-----------------------------------MENU-----------------------------------------------------------------------;
  titulo db '                         REGRAS DO JOGO', 13, 10, 0

  introducao db 'Essa e uma versao do mini-jogo THUNDERING DYNAMO, do Nitendo 64, em Assembly!', 13,10,0

  regra0 db 'Nesse mini-jogo os players devem clicar repetidamente na tecla correspondente a cor indicada', 13,10,0

  regra1 db 'Isso fara com que a energia seja recarregada', 13, 10, 0

  regra2 db 'Caso algum player clique com a tecla errada, parte da energia ja ganha sera drenada',  13,10,0

  regra3 db 'O jogador que completar a carga maxima primeiro ganha',  13,10,0

  bttn0 db 'Botao azul - Player1 deve pressionar A e Player2 K', 13, 10, 0

  bttn1 db 'Botao verde - Player1 deve pressionar S e Player2 L', 13, 10, 0

  press db '                        >PRESS ENTER TO START', 13, 10, 0

  ready db '                                  READY?', 13, 10, 0

  go db '                                  GO!', 13, 10, 0

  end0 db 'Parabens Player 1, voce ganhou!!!', 13, 10, 0

  

  end1 db 'Parabens Player 2, voce ganhou!!!', 13, 10, 0

  counter db 0


;----------------------------------------------------------------------------------------------------------;
 
	;----------------------GAME--------------------; 

	caracter db 0 	; 1 byte
	score1 db 0 	; pontuaccao
	score2 db 0 	; pontuaccao

	;eixo x
	c1 dw 20 	; barra do player 1
	c2 dw 170 	;barra do player 2
	;eixo y
	;dw pois cx tem 16 bits

	random db '0' ; 0 eh azul, 1 verde
	contador db 7; qtd de input para mudar cor
  ;------------------------------------------;




;----------------------------------------------------------------------------------------------------------;
start:

	xor ax, ax		
	mov ds, ax
	mov es, ax
  
  ;modo de grafico	
	mov ah,0 
	mov al, 12h
	int 10h

	;background
	mov ah,0xb
	mov bh, 0
	mov bl, 0 ; color
	int 10h
	
;----------code(main)-------------------
	
	call piscaTela
;---------------------------------------------;

	call fim1 ;printa pokebola
;---------------------------------------------;
	mov ah, 0  ;limpa a tela
	mov al, 12h
  int 10h

	mov ah,0xb
	mov bh, 0
	mov bl, 0 ; color
	int 10h

;------------------PRINT-MENU-----------------;
  	mov si, titulo
	mov bl, 7
	call printe

	mov si, introducao		
	call printe

	mov si, regra0		
	call printe

	mov si, regra1	
	call printe

	;mov si, regra2		
	;call printe

	mov si, regra3		
	call printe

	mov si, bttn0	
	call printe

	mov si, bttn1	
	call printe

	call tres_pula_linha

	mov si, press
	mov bl, 0x4
	call printe
;-------------------;
	mov ax, 0
	call inpute_enter
;-------------------;

  call jogo
;---------------------------------------------;
	
	jmp saiu

;----------FUNCOES ESTATICAS-------------	

piscaTela:
	
	mov ah, 0xb
	mov bh, 0
	mov bl, 0x4
	int 10h
	
	call delay
	
	mov ah, 0xb
	mov bh, 0
	mov bl, 0xe
	int 10h
	
	call delay
	
	mov ah, 0xb
	mov bh, 0
	mov bl, 0x1
	int 10h
	
	call delay

	mov ah, 0xb
	mov bh, 0
	mov bl, 0
	int 10h
	
	ret
	
delay:
	mov dx, 0
	.delei: ;delay
	inc dx
	mov cx, 0
		.time:
			inc cx
			cmp cx, 10000
			jne .time

	cmp dx, 3000
	jne .delei
	ret

delay2:
	mov dx, 0
	.delei: ;delay
	inc dx
	mov cx, 0
		.time:
			inc cx
			cmp cx, 10000
			jne .time

	cmp dx, 15000
	jne .delei
	ret
		
printe:
	lodsb
	
	mov ah, 0xe
	mov bh, 0
	;inc bl
	int 10h

	cmp al, 13
	jne printe
	ret

tres_pula_linha:
	mov ah, 0xe ;\n
	mov al, 0xd
	int 10h
	mov al, 0xa
	int 10h

	;mov ah, 0xe ;\n precisa chamar a funccao novamente
	mov al, 0xd
	int 10h
	mov al, 0xa
	int 10h

	;mov ah, 0xe ;\n
	mov al, 0xd
	int 10h
	mov al, 0xa
	int 10h

	ret

inpute_enter:	
	mov ah, 0
	int 16h	
	
	cmp al, 0xd
	jne inpute_enter
	ret
  
fim1:
	mov si, press
	mov bl, 0xf
	call tres_pula_linha
	call tres_pula_linha
	call tres_pula_linha
	
	call printe
	call pokebola
	mov ax, 0
	call inpute_enter
	ret
 
pokebola:
	mov ah, 0ch
	mov bh, 0
	mov al, 0x4 ; color
	mov cx, 280 ;x
	mov dx, 150 ;y
	int 10h
		
    mov bx, 0 ;vai ser meu contador de ciclos

	call v1	
  
	mov bx, 0
	mov cx, 270	
  
	call v2	
	   
    mov bx, 0
	mov cx, 260
	
    call v3
    mov al, 0xf	
    mov bx, 0				;muda a cor da pokebola
	call v3
	
    mov bx, 0
    mov cx, 270
  
	call v2
	
    mov bx, 0
	mov cx, 280
  
    call v1

	mov al, 0x7    ; parte especifica da pokebola
	mov dx, 170
	mov cx, 285
	mov bx, 0
  
  call v4
	
  ret
  
printar_bola:

	mov bx, 0 ;vai ser meu contador de ciclos

	call v1	
  
	mov bx, 0
	mov cx, 130	
  
	call v2	
	
    mov bx, 0
	mov cx, 120
	
    call v3
    mov bx, 0
    call v3
  
    mov bx, 0
    mov cx , 130
  
    call v2
  
    mov bx, 0
    mov cx, 140
  
    call v1
  
    ret

v1:
	mov cx, 140
	call linha1
  inc dx
  inc bx
  
  cmp bx, 3
  jne v1
	ret

v2:
	mov cx, 130
	call linha2
	inc dx
  inc bx
  
  cmp bx, 8
  jne v2
	ret

v3:
	mov cx, 120
	call linha3
	inc dx
  inc bx
  
  cmp bx, 14
  jne v3
	ret
  
v4:
	mov cx, 145
	call linha4
	inc dx
  inc bx
  
  cmp bx, 9
  jne v4
	ret
  
linha1:
	inc cx	
	int 10h

	cmp cx, 160
	jne linha1
	ret

linha2:
	inc cx	
	int 10h

	cmp cx, 170
	jne linha2
	ret

linha3:
	inc cx	
	int 10h

	cmp cx, 180
	jne linha3
	ret

linha4:
	inc cx	
	int 10h

	cmp cx, 155
	jne linha4
	ret
	

	
jogo: ;o jogo começa aqui

;-------tela do ready? go!--------------;
	mov ah, 0  ;limpa a tela
	mov al, 12h
  	int 10h

	mov ah,0xb
	mov bh, 0
	mov bl, 0 ; color
	int 10h

	call tres_pula_linha
	call tres_pula_linha
	call tres_pula_linha
	call tres_pula_linha


	mov si, ready  ;READY?
	mov bl, 0xf
	call printe
	
	call delay2
	
	mov ah, 0  ;limpa a tela
	mov al, 12h
    int 10h

	mov ah,0xb
	mov bh, 0
	mov bl, 0 ; color
	int 10h

	call tres_pula_linha
	call tres_pula_linha
	call tres_pula_linha
	call tres_pula_linha
	
	mov si, go     ;GO!
	mov bl, 0xf
	call printe

	call delay2

;------------começa a partida-------------

	;limpa a tela	
  	mov ah, 0  ;limpa a tela
	mov al, 13h
    int 10h


;background
	mov ah, 0xb
	mov bh,0
	mov bl, 0 ; color ;0X9
	int 10h
;-------------------------------------;
fundo:
	mov cx, 15
	mov dx, 165
	call barrinha_magenta

	mov cx, 165
	mov dx, 165
	call barrinha_magenta1




	;colocar aqui as barras da bola #FALTA
;-------------------------------------;
  	call pikachu ;printa o pikachu
	call bulbassauro ;printa o bulbossauro

	
	

	
	call printar_bola_azul  
	;pois bugs
	mov byte[score1], 0 ;pq tava dando bug
	;c1 dw 20 	; barra do player 1
	;c2 dw 170
	mov word[c1], 20
	mov word[c2], 170


	;BARRAS DE STATUS	
	mov al, 0xe 		; color

	mov bl, 0 			;zerando reg para atualizar score
	
	;loop eh palavra reservada no macSO
	loopi:
		
		call randoim 

		;Read key press
		mov ah, 00h 
		int 16h
		mov byte[caracter], al
		
		;print test
		;mov ah, 0xe
		;mov bl, 0xd
		;int 10h
		
		cmp byte[random], '0' ; blue
		jne .green
			cmp byte[caracter], 'a' ;0x61
			je .player1

			cmp byte[caracter], 'j' ;
			je .player2

			jmp loopi 

		.green:
			cmp byte[caracter], 's' 
			je .player1

			cmp byte[caracter], 'k' 
			je .player2
		
		jmp loopi
;======================================================

.player1:
	
		
		mov dx, 170
		mov cx, word[c1]
		;if press
       
		mov bl, byte[score1]
		inc bl 		; +1 score 
		mov byte[score1], bl 		; atualiza [MEM]
		mov bl, 0xd
		mov bh, 0
		
		inc cx
		call coluna
		mov dx, 170 ; pra voltar ao normal
		inc cx
		call coluna
		mov dx, 170 ; pra voltar ao normal
		inc cx
		call coluna
		mov dx, 170 ; pra voltar ao normal
		inc cx
		call coluna
		mov dx, 170 ; pra voltar ao normal




		cmp byte[score1], 25 		; score max
		je resultado
		

		


		mov word[c1], cx
		jmp loopi 		; prox input

;======================================================
.player2:
	
		mov dx, 170
		mov cx, word[c2]
		;if press
		mov bl, byte[score2]
		inc bl 		; +1 score 
		mov byte[score2], bl 		; atualiza [MEM]
		mov bl, 0xd
		mov bh, 0
		
		inc cx
		call coluna
		mov dx, 170 ; pra voltar ao normal
		inc cx
		call coluna
		mov dx, 170 ; pra voltar ao normal
		inc cx
		call coluna
		mov dx, 170 ; pra voltar ao normal
		inc cx
		call coluna
		mov dx, 170 ; pra voltar ao normal

		cmp byte[score2], 25 		; score max
		je resultado

		mov word[c2], cx
		jmp loopi 		; prox input
;======================================================

coluna:
	
	mov ah, 0ch ; write graphics pixel
	mov bh, 0 ; page
	mov al, 0xe ; color
	int 10h

	inc dx
	int 10h

	cmp dx, 180
	jne coluna

	
	ret
;



;=====================================================
randoim: ;a função random que escolhe a cor da bola
	cmp byte[contador],0
	jne nmuda

	mov byte[random], 0h	;zera pra n ter lixo

	mov ah, 00h
	int 1ah

	mov ax, dx
	xor dx, dx
	mov cx, 2
	div cx
	
	add dl, 48
	mov byte[random], 0h	; LIMPA PF EU TE IMPLORO
	mov byte[random], dl

	;PINTA CIRCULO
	call colorir
	;mov ah, 0xe
	;mov al, dl
	;mov bl, 0xf
	;int 10h
	
	;voltando com o y ao normal
	mov dx, 170

	mov byte[contador], 6
	nmuda:
	
		;decrementando o contador
		mov bl, byte[contador]
		dec bl 		; +1 score 
		mov byte[contador], bl 		; atualiza [MEM]
		mov bl, 0xd

		ret
;=====================================================

colorir:
	;'0' == azul (blau)
	;'1'== verde (gruen)
	cmp dl, '0';
	jne gruen
		call printar_bola_azul
		ret
	gruen:
		call printar_bola_verde
		ret

;=====================BOLAS============================

;-----------azul---------------

printar_bola_azul:
	;xor cx, cx
	;xor dx, dx
    mov ah, 0ch
    mov bh, 0
    mov al, 0x1 ; color      ; cor azul
    mov cx, 140 ;x
    mov dx, 30 ;y
    int 10h

    call printar_bola
	mov dx, 170
    ret


;--------verde---------------

printar_bola_verde:
	;xor cx, cx
	;xor dx, dx
    mov ah, 0ch
    mov bh, 0
    mov al, 0x2 ; color      ; cor verde
    mov cx, 140 ;x
    mov dx, 30 ;y
    int 10h

    call printar_bola
	mov dx, 170
    ret

;======================================================
;

barrinha_magenta:     ; nao e magenta viu, aqui e pegadinha do malandro!!!
	
	mov ah, 0ch ; write graphics pixel
	mov bh, 0 ; page
	mov al, 0xc ; color

	linha_magenta:
		inc cx
		coluna_magenta:
			inc dx			
			int 10h

			cmp dx, 185
			jne coluna_magenta
				
			mov dx, 165
	
		cmp cx, 125
		jne linha_magenta
		ret
;-----------
barrinha_magenta1:     ; nao e magenta viu, aqui e pegadinha do malandro!!!
	
	mov ah, 0ch ; write graphics pixel
	mov bh, 0 ; page
	mov al, 0xc ; color

	linha_magenta1:
		inc cx
		coluna_magenta1:
			inc dx			
			int 10h

			cmp dx, 185
			jne coluna_magenta1
				
			mov dx, 165
	
		cmp cx, 275
		jne linha_magenta1
		ret

;======================================================
;----------------------fim de jogo---------------------- 
  resultado:


	;limpa a tela	
  	mov ah, 0  ;limpa a tela
	mov al, 0xd
    int 10h


	;background
	mov ah, 0xb
	mov bh,0
	mov bl, 0 ; color ;0X9
	int 10h



won: ;define quem venceu

	cmp byte[score1], 25	;player 1
	jne pleir2
		call umvenceu
		ret
	pleir2:	;player 2
		call doisvenceu
		ret



umvenceu:  ;a tela se o jogador 1 vencer
	mov si, end0
	mov bl, 0xf
	call printe
	call trofeu
	ret

doisvenceu:  ;a tela se o jogador 2 vencer
	mov si, end1
	mov bl, 0xf
	call printe
	call trofeu
ret
;-----------------------printar pikachu----------------------------------
pikachu:
	mov cx, 50
	mov dx, 120

	mov si, p1
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx   

	mov si, p2
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx   

	mov si, p3
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx   

	mov si, p4
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx   

	mov si, p5
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx   

	

	mov si, p6
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx    

	mov si, p7
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx 

	mov si, p8
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx 

	mov si, p9
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx    

	mov si, p10
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx 

	mov si, p11
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx
	mov si, p12
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx    

	mov si, p13
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx 

	mov si, p14
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx

	mov si, p15
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx 

	mov si, p16
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx

	mov si, p17
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx    

	mov si, p18
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx 

	mov si, p19
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx

	mov si, p20
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx
	mov si, p21
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx    

	mov si, p22
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx 

	mov si, p23
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx

	mov si, p24
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx 

	mov si, p25
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx   
	
	mov si, p26
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx

	mov si, p27
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx 

	mov si, p28
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx 

	mov si, p29
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx    

	mov si, p30
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx                

	mov si, p31
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx                

	mov si, p32
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx                

	mov si, p33
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx                

	mov si, p34
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx                

	mov si, p35
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx   

	mov si, p36
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx                

	mov si, p37
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx                

	mov si, p38
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx                

	mov si, p39
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx                

	mov si, p40
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx                


	mov si, p41
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx                

	mov si, p42
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx                

	mov si, p43
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx                

	mov si, p44
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx                

	mov si, p45
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 50
	inc dx                    
	                                                                                                                                        
 ret
	
;--------------------printar trofeu---------------------------
trofeu:
	mov cx, 125
	mov dx, 50


	mov si, t4
	mov byte[counter], 0
	call printe_imagem
	mov cx, 125
	inc dx
	mov si, t5
	mov byte[counter], 0
	call printe_imagem
	mov cx, 125
	inc dx

	mov si, t6
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx    

	mov si, t7
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx 

	mov si, t8
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx 

	mov si, t9
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx    

	mov si, t10
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx 

	mov si, t11
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx
	mov si, t12
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx    

	mov si, t13
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx 

	mov si, t14
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx

	mov si, t15
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx 

	mov si, t16
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx

	mov si, t17
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx    

	mov si, t18
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx 

	mov si, t19
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx

	mov si, t20
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx
	mov si, t21
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx    

	mov si, t22
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx 

	mov si, t23
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx

	mov si, t24
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx 

	mov si, t25
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx   
	
	mov si, t26
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx

	mov si, t27
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx 

	mov si, t28
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx 

	mov si, t29
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx    

	mov si, t30
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                

	mov si, t31
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                

	mov si, t32
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                

	mov si, t33
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                

	mov si, t34
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                

	mov si, t35
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx   

	mov si, t36
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                

	mov si, t37
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                

	mov si, t38
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                

	mov si, t39
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                

	mov si, t40
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                


	mov si, t41
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                

	mov si, t42
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                

	mov si, t43
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                

	mov si, t44
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                

	mov si, t45
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                

	mov si, t46
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx   

	mov si, t47
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                

	mov si, t48
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                

	mov si, t49
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                

	mov si, t50
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx      

	mov si, t51
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 125
	inc dx                

ret

;------------printar bulbossauro-------------------------
bulbassauro:
	mov cx, 200
	mov dx, 133

	mov si, b1
	mov byte[counter], 0
	call printe_imagem

	mov cx, 200
	inc dx

	mov si, b2
	mov byte[counter], 0
	call printe_imagem
	mov cx, 200
	inc dx
	mov si, b3
	mov byte[counter], 0
	call printe_imagem
	mov cx, 200
	inc dx
	mov si, b4
	mov byte[counter], 0
	call printe_imagem
	mov cx, 200
	inc dx
	mov si, b5
	mov byte[counter], 0
	call printe_imagem
	mov cx, 200
	inc dx

	mov si, b6
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx    

	mov si, b7
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx 

	mov si, b8
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx 

	mov si, b9
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx    

	mov si, b10
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx 

mov si, b11
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx

	mov si, b12
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx    

	mov si, b13
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx 

	mov si, b14
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx

	mov si, b15
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx 

	mov si, b16
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx

	mov si, b17
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx    

	mov si, b18
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx 

	mov si, b19
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx

	mov si, b20
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx

	mov si, b21
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx    

	mov si, b22
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx 

	mov si, b23
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx

	mov si, b24
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx 

	mov si, b25
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx   
	
	mov si, b26
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx

	mov si, b27
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx 

	mov si, b28
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx 

	mov si, b29
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx    

	mov si, b30
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx                

	mov si, b31
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx                

	mov si, b32
	mov byte[counter], 0   
	call printe_imagem
	mov cx, 200
	inc dx 

  

ret



;------------------------pikachu----------------------------------------------------------

p1 db 7,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p2 db 7,14,14,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p3 db 7,14,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p4 db 7,14,14,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,14,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p5 db 0,7,14,14,14,14,14,7,0,0,0,0,0,7,7,7,7,7,0,0,0,0,0,0,0,7,7,14,14,14,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p6 db 0,0,7,14,14,14,14,14,7,0,0,7,7,14,14,14,14,14,7,7,7,0,0,7,7,14,14,14,14,14,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p7 db 0,0,0,7,14,14,14,14,14,7,7,14,14,14,14,14,14,14,14,14,14,7,7,14,14,14,14,14,14,14,14,14,7,0,0,0,0,0,0,0,0,7,7,7,0,0,0,0,0,0
p8 db 0,0,0,0,7,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,7,0,0,0,0,0,0,0,7,14,14,14,7,0,0,0,0,0
p9 db 0,0,0,0,0,7,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,7,7,0,0,0,0,0,0,7,7,14,14,14,14,7,0,0,0,0,0
p10 db 0,0,0,0,0,0,7,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,7,7,7,0,0,0,0,0,0,0,7,14,14,14,14,14,14,14,7,0,0,0,0
p11 db 0,0,0,0,0,0,7,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,7,0,0,0,0,0,0,0,0,0,7,14,14,14,14,14,14,14,14,14,7,0,0,0
p12 db 0,0,0,0,0,0,0,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,7,0,0,0,0,0,0,0,0,7,14,14,14,14,14,14,14,14,14,14,7,0,0,0
p13 db 0,0,0,0,0,7,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,7,0,0,0,0,0,7,7,7,14,14,14,14,14,14,14,14,14,14,14,14,7,0,0
p14 db 0,0,0,0,7,14,14,0,15,15,14,14,14,14,14,14,14,14,15,15,0,14,14,14,14,14,7,0,0,0,7,7,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,0,0
p15 db 0,0,0,0,7,14,14,0,15,15,14,14,14,14,14,14,14,14,15,15,0,14,14,14,14,14,14,7,0,7,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,7,0,0
p16 db 0,0,0,0,7,14,14,0,0,0,14,14,14,14,14,14,14,14,0,0,0,14,14,14,14,14,14,7,0,7,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,7,7,0,0,0
p17 db 0,0,0,7,7,4,4,14,14,14,14,0,0,0,14,14,14,14,14,14,14,14,14,14,14,14,14,7,0,0,7,14,14,14,14,14,14,14,14,14,14,14,14,7,7,0,0,0,0,0
p18 db 0,0,0,7,4,4,4,4,14,14,14,14,0,14,14,14,14,14,14,14,14,4,4,14,14,14,14,7,0,0,7,14,14,14,14,14,14,14,14,14,7,7,7,0,0,0,0,0,0,0
p19 db 0,0,0,7,4,4,4,4,14,14,0,0,0,0,0,14,14,14,14,14,4,4,4,4,14,14,14,7,0,0,0,7,14,14,14,14,14,14,14,7,0,0,0,0,0,0,0,0,0,0
p20 db 0,0,0,7,7,4,4,14,14,14,14,0,0,0,14,14,14,14,14,4,4,4,4,4,4,14,14,14,7,0,0,7,7,14,14,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0
p21 db 0,0,0,0,7,7,14,14,14,14,14,14,14,14,14,14,14,14,14,14,4,4,4,4,14,14,14,14,7,0,0,0,7,14,14,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0
p22 db 0,0,0,0,0,7,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,4,4,14,14,14,14,14,7,0,0,0,0,7,14,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0
p23 db 0,0,0,0,0,0,7,14,14,14,14,0,14,14,0,14,14,14,14,14,14,14,14,14,14,14,14,14,7,0,0,0,0,7,14,14,14,7,7,0,0,0,0,0,0,0,0,0,0,0
p24 db 0,0,0,7,7,7,0,0,0,14,14,14,0,0,14,14,14,14,14,14,14,14,14,14,14,14,14,14,7,0,0,0,0,7,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0
p25 db 0,0,0,7,0,0,14,14,14,0,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,7,0,0,0,7,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0
p26 db 0,0,0,7,0,14,14,14,14,14,14,14,14,14,14,14,14,14,14,0,0,14,14,14,14,14,6,6,6,7,0,7,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p27 db 0,0,0,7,0,14,14,14,14,14,0,14,14,14,14,14,14,14,14,0,14,14,14,14,14,6,6,6,6,7,0,7,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p28 db 0,0,0,7,0,14,14,14,14,14,0,0,14,14,14,14,14,14,0,14,14,14,14,14,14,14,6,6,6,7,0,7,6,6,6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p29 db 0,0,0,7,0,14,14,14,14,14,14,0,14,14,14,14,14,0,14,14,14,14,14,14,14,14,14,14,14,7,7,7,6,6,6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p30 db 0,0,0,7,0,14,14,14,14,14,14,0,14,14,14,14,14,0,14,14,14,14,14,14,0,14,14,14,14,14,7,6,6,6,6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p31 db 0,0,0,7,0,0,14,14,14,14,14,0,14,14,14,14,0,14,14,14,14,14,14,14,0,14,14,14,14,14,7,6,6,6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p32 db 0,0,0,0,7,0,0,14,14,14,14,0,14,14,14,14,0,14,14,14,14,14,14,0,0,14,14,14,14,14,7,6,6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p33 db 0,0,0,0,0,7,7,0,14,14,14,0,14,14,14,14,0,14,14,14,14,14,0,0,14,14,14,14,6,6,7,6,6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p34 db 0,0,0,0,0,0,7,0,14,14,0,0,14,14,14,14,0,14,14,14,0,0,0,14,14,14,14,6,6,6,6,6,6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p35 db 0,0,0,0,0,0,7,0,0,0,14,14,14,14,14,14,14,0,0,0,0,14,14,14,14,14,14,14,6,6,6,6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p36 db 0,0,0,0,0,0,7,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p37 db 0,0,0,0,0,0,7,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p38 db 0,0,0,0,0,0,7,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p39 db 0,0,0,0,0,0,7,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p40 db 0,0,0,0,0,0,0,7,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p41 db 0,0,0,0,0,0,0,0,7,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p42 db 0,0,0,0,0,0,0,7,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p43 db 0,0,0,0,0,0,7,14,14,14,14,7,7,7,7,7,7,7,7,14,14,14,14,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p44 db 0,0,0,0,0,7,14,14,14,14,7,0,0,0,0,0,0,0,0,7,7,14,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p45 db 0,0,0,0,0,7,14,14,14,7,0,0,0,0,0,0,0,0,0,0,7,14,14,14,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0


;----------------------trofeu------------------------------------------------------------


t4 db 0,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,0,0
t5 db 0,0,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,0,0,0
t6 db 0,0,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,0,0,0
t7 db 0,0,0,0,0,0,0,8,8,8,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,8,8,8,0,0,0,0,0,0,0,0
t8 db 0,0,0,0,0,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,0,0,0,0,0,0
t9 db 0,0,0,0,0,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,0,0,0,0,0,0
t10 db 0,0,0,0,0,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,0,0,0,0,0,0
t11 db 0,0,0,0,8,8,8,8,8,8,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,8,8,8,8,8,8,0,0,0,0,0
t12 db 0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0
t13 db 0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0
t14 db 0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0
t15 db 0,8,8,8,8,8,8,8,8,8,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,8,8,8,8,8,8,8,8,8,0,0
t16 db 0,8,14,14,8,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,8,14,14,8,0,0
t17 db 0,8,14,14,8,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,8,14,14,8,0,0
t18 db 0,8,14,14,8,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,8,14,14,8,0,0
t19 db 0,8,14,14,8,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,8,14,14,8,0,0
t20 db 0,8,14,14,8,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,8,14,14,8,0,0
t21 db 0,8,14,14,8,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,8,14,14,8,0,0
t22 db 0,8,14,14,8,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,8,14,14,8,0,0
t23 db 0,8,14,14,8,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,8,14,14,8,0,0
t24 db 0,8,14,14,8,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,8,14,14,8,0,0
t25 db 0,8,8,8,8,8,8,8,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,8,8,8,8,8,8,8,0,0
t26 db 0,0,0,0,8,14,14,8,0,0,8,8,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,8,8,0,0,8,14,14,8,0,0,0,0,0
t27 db 0,0,0,0,8,14,14,8,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,8,14,14,8,0,0,0,0,0
t28 db 0,0,0,0,8,8,8,8,8,8,8,8,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,8,8,8,8,8,8,8,8,0,0,0,0,0
t29 db 0,0,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,0,0,0
t30 db 0,0,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,0,0,0
t31 db 0,0,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,0,0,0
t32 db 0,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,0,0
t33 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
t34 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,8,8,8,14,14,14,14,14,14,14,14,14,14,14,8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
t35 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
t36 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
t37 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,8,8,8,14,14,14,14,14,8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
t38 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,14,14,14,14,14,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
t39 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,14,14,14,14,14,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
t40 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,14,14,14,14,14,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
t41 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,14,14,14,14,14,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
t42 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,14,14,14,14,14,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
t43 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,14,14,14,14,14,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
t44 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,14,14,14,14,14,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
t45 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,14,14,14,14,14,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
t46 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,14,14,14,14,14,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
t47 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,14,14,14,14,14,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
t48 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,8,8,8,8,8,8,14,14,14,14,14,8,8,8,8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
t49 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
t50 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
t51 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

;-------------bulbasauro--------------------------------------------------------------
b1 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
b2 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,2,2,2,2,2,2,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
b3 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,2,2,2,2,2,2,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
b4 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,2,2,2,0,0,2,2,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
b5 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,2,2,2,2,0,0,2,2,2,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
b6 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,2,2,2,2,2,2,0,0,2,2,0,0,2,2,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
b7 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,2,2,2,2,2,2,0,0,2,2,0,0,2,2,7,7,7,7,0,0,0,0,0,0,0,0,0,0,0,0
b8 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,2,2,2,2,0,0,2,2,2,2,0,0,2,2,0,0,2,2,2,2,2,2,7,0,0,0,0,0,0,0,0,0,0,0
b9 db 0,0,0,0,0,0,0,0,7,7,0,0,0,0,0,7,2,2,2,2,0,0,2,2,2,2,0,0,2,2,0,0,2,2,2,2,2,2,7,7,0,0,0,0,0,0,0,0,0,0
b10 db 0,0,0,0,0,0,0,7,11,11,7,0,0,0,0,7,2,2,0,0,2,2,2,2,2,2,0,0,2,2,2,2,0,0,2,2,2,2,2,2,7,0,0,0,0,0,0,0,0,0
b11 db 0,0,0,0,0,0,0,7,11,11,7,7,7,7,7,7,2,2,0,0,2,2,2,2,2,2,0,0,2,2,2,2,0,0,2,2,2,2,2,2,7,0,0,0,0,0,0,0,0,0
b12 db 0,0,0,0,0,0,0,7,11,11,11,11,11,11,11,11,0,0,0,0,2,2,2,2,0,0,2,2,2,2,2,2,2,2,0,0,2,2,2,2,7,0,0,0,0,0,0,0,0,0
b13 db 0,0,0,0,0,0,0,7,11,11,11,11,11,11,11,11,0,0,0,0,2,2,2,2,0,0,2,2,2,2,2,2,2,2,0,0,2,2,2,2,7,0,0,0,0,0,0,0,0,0
b14 db 0,0,0,0,0,0,0,7,11,11,11,11,11,11,11,11,11,11,11,11,0,0,2,2,0,0,2,2,2,2,2,2,2,2,0,0,2,2,2,2,7,0,0,0,0,0,0,0,0,0
b15 db 0,0,0,0,0,0,7,7,11,11,11,11,11,11,11,11,3,3,3,11,0,0,2,2,0,0,2,2,2,2,2,2,2,2,0,0,2,2,2,2,7,0,0,0,0,0,0,0,0,0
b16 db 0,0,0,0,0,7,11,11,11,11,3,3,11,11,3,3,3,3,11,11,11,11,0,0,0,0,0,0,2,2,2,2,2,2,0,0,2,2,7,7,0,0,0,0,0,0,0,0,0,0
b17 db 0,0,0,0,0,7,11,11,11,11,3,3,11,11,3,3,3,3,11,11,11,11,0,0,0,0,0,0,2,2,2,2,2,2,0,0,2,2,7,7,0,0,0,0,0,0,0,0,0,0
b18 db 0,0,0,0,0,7,3,3,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,0,0,2,2,2,2,0,0,0,0,0,0,11,11,7,0,0,0,0,0,0,0,0,0
b19 db 0,0,0,0,0,7,3,3,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,0,0,2,2,2,2,0,0,0,0,0,0,11,11,7,0,0,0,0,0,0,0,0,0
b20 db 0,0,0,0,0,7,3,3,11,11,11,11,11,11,3,3,11,11,11,11,11,11,11,11,0,0,3,3,0,0,0,0,0,0,11,11,11,11,3,11,7,0,0,0,0,0,0,0,0,0
b21 db 0,0,0,7,7,7,3,3,11,11,11,11,11,11,3,3,11,11,11,11,11,11,11,11,0,0,3,3,0,0,0,0,0,0,11,11,3,3,3,11,7,0,0,0,0,0,0,0,0,0
b22 db 0,0,0,7,11,11,11,11,11,11,11,11,3,3,8,8,0,0,0,0,11,11,11,11,3,3,3,3,3,3,3,3,3,3,7,7,11,3,11,11,7,0,0,0,0,0,0,0,0,0
b23 db 0,0,0,7,11,11,11,11,11,11,11,11,3,3,8,8,0,0,0,0,11,11,11,11,3,3,3,3,3,3,3,3,3,3,7,7,11,11,15,15,7,0,0,0,0,0,0,0,0,0
b24 db 0,0,0,7,3,3,11,11,11,11,11,11,11,11,0,0,4,4,15,15,15,15,11,11,3,3,0,0,3,3,0,0,15,15,7,7,7,7,7,7,0,0,0,0,0,0,0,0,0,0
b25 db 0,0,0,7,3,3,11,11,11,11,11,11,11,11,0,0,4,4,15,15,15,15,11,11,3,3,0,0,3,3,0,0,15,15,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
b26 db 0,0,0,0,7,7,3,3,11,11,11,11,11,11,0,0,4,4,15,15,11,11,3,3,0,0,3,3,3,3,3,3,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
b27 db 0,0,0,0,0,7,3,3,11,11,11,11,11,11,0,0,4,4,15,15,11,11,3,3,0,0,3,3,3,3,3,3,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
b28 db 0,0,0,0,0,0,7,7,7,7,11,3,3,3,3,3,3,3,3,3,3,3,7,7,3,3,3,3,3,3,3,3,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
b29 db 0,0,0,0,0,0,0,0,0,7,3,3,3,3,3,3,3,3,3,3,3,3,7,7,3,3,3,3,3,3,3,3,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
b30 db 0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,15,15,3,3,15,15,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
b31 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,15,15,3,3,15,15,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
b32 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0


printe_imagem:

	lodsb
	mov ah, 0ch ; write graphics pixel
	mov bh, 0 ; page
	mov bl, al
	int 10h
	add byte[counter], 1
	inc cx

	cmp byte[counter], 51
	jne printe_imagem
	ret
	



	
  
  saiu:
  	jmp $ 
;=======================================================

