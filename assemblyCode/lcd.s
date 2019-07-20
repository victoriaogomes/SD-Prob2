.equ switches, 0x00003030
.equ leds, 0x00003020

.global _start


_start:
	movia r2, switches # Move para r2 o endereço dos switches
	movia r3, leds # Move para r3 o endereço dos leds
	call turn_led_off # Chama a função que desligará todos os leds
	call set_constants # Chama a função que seta as constantes para os delays utilizados
	call initialize_lcd # Chama a função que inicializa o LCD
	call state_zero # Chama a função state_zero, começando a execução da máquina de estados


set_constants:
	movia r11, 0x0 # r11 -> contador, inicializado como 0
	movia r8, 0xF424 # r8 -> valor para o delay de 15ms
	movia r9, 0x42BB # r9 -> valor para o delay de 4.1ms
	movia r10, 0x1A0 # r10 -> valor para o delay de 0.1ms
	movia r12, 0x65B9A # r12 -> valor para o delay de 100ms
	movia r13, 0xDC # r13 -> valor para o delay de 0.053ms
	ret # Retorna para a rotina que chamou essa label


initialize_lcd:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	call delay_100ms # Delay de 100ms quando o LCD é ligado
	movia r16, 0x30 # Código que define o function set do LCD
	call delay_0_1ms # Delay de 0.1ms
	movia r17, 0x0 # Código que vai ser armazenado no PINRS, indica que instruções serão enviadas
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Definindo function set do LCD
	call delay_15ms # Delay de 15ms
	custom 0, r23, r17, r16 # Definindo function set do LCD novamente
	call delay_15ms # Delay de 15ms
	custom 0, r23, r17, r16 # Definindo function set do LCD novamente
	call delay_100ms # Delay de 100ms
	movia r16, 0x38 # Function set real do LCD
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Definindo function set real do LCD
	call delay_100ms # Delay de 100ms
	movia r16, 0x08 # Código para desligar o LCD
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Desligando o LCD
	call delay_100ms # Delay de 100ms
	movia r16, 0x01 # Código para limpar LCD
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Limpando o LCD
	call delay_100ms # Delay de 100ms
	movia r16, 0x06 # Código para definir o Entry Mode Set do LCD
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Definindo Entry Mode Set do LCD
	call delay_0_053ms # Delay de 0.053ms
	movia r16, 0x0C # Código para ligar o LCD
	call delay_0_1ms # Delay de 0.1ms
	custom 0, r23, r17, r16 # Ligando o LCD
	call delay_0_053ms # Delay de 0.53ms
	movia r17, 0x1 # Mudando PINRS para envio de dados
	call delay_4_1ms # Delay de 4.1ms
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label

# ----------------------------------------------------   DELAYS ----------------------------------------------------- #
delay_15ms: 
	addi r11, r11, 1 # Adiciona 1 no registrador r11
	bne r11, r8, delay_15ms # Verifica se r11 armazena mesmo valor que r8 (se não, volta pro início do looping)
	addi r11, r0, 0 # Zera o registrador r11
	ret # Retorna para a rotina que chamou essa label


delay_4_1ms:
	addi r11, r11, 1 # Adiciona 1 no registrador r11
	bne r11, r9, delay_4_1ms # Verifica se r11 armazena mesmo valor que r9 (se não, volta pro início do looping)
	addi r11, r0, 0 # Zera o registrador r11
	ret # retorna para a rotina que chamou essa label


delay_0_1ms:
	addi r11, r11, 1 # Adiciona 1 no registrador r11
	bne r11, r10, delay_0_1ms # Verifica se r11 armazena mesmo valor que r10 (se não, volta pro início do looping)
	addi r11, r0, 0 # Zera o registrador r11
	ret # Retorna para a rotina que chamou essa label


delay_100ms:
	addi r11, r11, 1 # Adiciona 1 no registrador r11
	bne r11, r12, delay_100ms # Verifica se r11 armazena mesmo valor que r12 (se não, volta pro início do looping)
	addi r11, r0, 0 # Zera o registrador r11
	ret # Retorna para a rotina que chamou essa label


delay_0_053ms:
	addi r11, r11, 1 # Adiciona 1 no registrador r11
	bne r11, r13, delay_0_053ms # Verifica se r11 armazena mesmo valor que r13 (se não, volta pro início do looping)
	addi r11, r0, 0 # Zera o registrador r11
	ret # Retorna para a rotina que chamou essa label

# ---------------------------------------------   ALTERNÂNCIA ENTRE LINHAS -------------------------------------------------- #
line_one: # Muda o cursor do display para a primeira linha
	movia r17, 0x0 # Mudando PINRS para envio de instruções
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	call delay_4_1ms # Delay de 4.1ms
	movia r16, 0x80 # Código para mudar cursor para primeira linha
	call delay_4_1ms # Delay de 4.1ms
	custom 0, r23, r17, r16 # Mudando cursor para primeira linha
	call delay_100ms # Delay de 100ms
	movia r17, 0x1 # Mudando PINRS para envio de dados
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label


line_two: # Muda o cursor do display para a segunda linha
	movia r17, 0x0 # Mudando PINRS para envio de instruções
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	call delay_4_1ms # Delay de 4.1ms
	movia r16, 0xC0 # Código para mudar cursor para segunda linha
	call delay_4_1ms # Delay de 4.1ms
	custom 0, r23, r17, r16 # Mudando cursor para segunda linha
	call delay_100ms # Delay de 100ms
	movia r17, 0x1 # Mudando PINRS para envio de dados
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label


line_three: # Muda o cursor do LCD para o terceira linha
	movia r17, 0x0 # Mudando PINRS para envio de instruções
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	call delay_4_1ms # Delay de 4.1ms
	movia r16, 0x94 # Código para mudar cursor para terceira linha
	call delay_4_1ms # Delay de 4.1ms
	custom 0, r23, r17, r16 # Mudando cursor para terceira linha
	call delay_100ms # Delay de 100ms
	movia r17, 0x1 # Mudando PINRS para envio de dados
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label


line_four: # Muda o cursor do lcd para a quarta linha do display
	movia r17, 0x0 # Mudando PINRS para envio de instruções
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	call delay_4_1ms # Delay de 4.1ms
	movia r16, 0xD4 # Código para mudar cursor para quarta linha
	call delay_4_1ms # Delay de 4.1ms
	custom 0, r23, r17, r16 # Mudando cursor para quarta linha
	call delay_100ms # Delay de 100ms
	movia r17, 0x1 # Mudando PINRS para envio de dados
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label

# ----------------------------------------------------  MÁQUINA DE ESTADOS ----------------------------------------------------- #
state_zero: # Estado inicial da máquina
	movia r19, 0x30 # Salva em r19 que a máquina se encontra no estado 0
	call clear_lcd # Limpa a tela do display
	call line_one # Chama a função para ir para a linha inicial
	call write_arrow # Desenha uma seta na opção selecionada
	call write_menu # Função que escreve "Menu"
	movia r16, 0x30 # Move o caractere "0" para r16
	call write # Chama a função que escreve no lcd o que está em r16
	call line_two # Função que joga o cursor do lcd para a segunda linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x31 # Caractere "1"
	call write # Chama a função para escrever o que está no registrador r16
	call line_three # Função que joga o cursor do lcd para a terceira linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x32 # Caractere "2"
	call write # Escreve o que estiver no registrador r16
	call line_four # Joga o cursor do lcd na quarta linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x33 # Caractere "3"
	call write # Escreve o caractere armazenado em r16
	call write # Repete a escrita pois o display tem mania de ignorar o último caractere
	call loop_zero # Chama a label que contém o loop que irá esperar por comandos dos botões do estado 2


state_one: # Segundo estado da máquina, as quatro primeiras opções do display com a segunda sendo destacada
	movia r19, 0x31 # Salva em r19 que a máquina se encontra do primeiro estado
	call clear_lcd # Limpa o display
	call line_one # Move o cursor para a primeira linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x30 # Caractere "0"
	call write # Escreve o valor movido para r16
	call line_two # Move o cursor para a segunda linha
	call write_arrow # Escreve a seta que seleciona o menu
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x31 # Caractere "1"
	call write # Escreve o valor armazenado em r16
	call line_three # Move o cursor para a terceira linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x32 # Caractere "2"
	call write # Escreve o valor armazenado em r16
	call line_four # Move o cursor para a quarta linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x33 # Caractere "3"
	call write # Escreve o valor armazendo no registrador de r16
	call write # Repete a escrita pois o display tem mania de ignorar o último caractere
	call loop_one # Chama a label que contém o loop que irá esperar por comandos dos botões do segundo estado


state_two: # Terceiro estado da máquina, as quatro primeiras opções do display com a terceira sendo destacada
	movia r19, 0x32 # Salva em r19 que a máquina se encontra no estado 2
	call clear_lcd # Limpa o display
	call line_one # Move o cursor para a primeira linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x30 # Caractere "0"
	call write # Escreve o valor armazendo no registrador de r16
	call line_two # Move o cursor para a segunda linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x31 # Caractere "1"
	call write # Escreve o valor armazendo no registrador de r16
	call line_three # Move o cursor para a terceira linha
	call write_arrow # Escreve a seta que seleciona o menu
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x32 # Caractere "2"
	call write # Escreve o valor armazendo no registrador de r16
	call line_four # Move o cursor para a quarta linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x33 # Caractere "3"
	call write # Escreve o valor armazendo no registrador de r16
	call write # Repete a escrita pois o display tem mania de ignorar o último caractere
	call loop_two # Chama a label que contém o loop que irá esperar por comandos dos botões do terceiro estado


state_three: # Quarto estado da máquina, as quatro primeiras opções do display com a quarta sendo destacada
	movia r19, 0x33 # Salva em r19 que a máquina se encontra no estado 3
	call clear_lcd # Limpa o display
	call line_one # Move o cursor para a primeira linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x30 # Caractere "0"
	call write # Escreve o valor armazendo no registrador de r16
	call line_two # Move o cursor para a segunda linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x31 # Caractere "1"
	call write # Escreve o valor armazendo no registrador de r16
	call line_three # Move o cursor para a terceira linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x32 # Caractere "2"
	call write # Escreve o valor armazendo no registrador de r16
	call line_four # Move o cursor para a quarta linha
	call write_arrow # Escreve a seta que seleciona o menu
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x33 # Caractere "3"
	call write # Escreve o valor armazendo no registrador de r16
	call write # Repete a escrita pois o display tem mania de ignorar o último caractere
	call loop_three # Chama a label que contém o loop que irá esperar por comandos dos botões do quarto estado


state_four: # Quinto estado da máquina, as quatro primeiras opções do display com a quinta sendo destacada
	movia r19, 0x34 # Salva em r19 que a máquina se encontra no estado 4
	call clear_lcd # Limpa o display
	call line_one # Move o cursor para a primeira linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x31 # Caractere "1"
	call write # Escreve o valor armazendo no registrador de r16
	call line_two # Move o cursor para a segunda linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x32 # Caractere "2"
	call write # Escreve o valor armazendo no registrador de r16
	call line_three # Move o cursor para a terceira linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x33 # Caractere "3"
	call write # Escreve o valor armazendo no registrador de r16
	call line_four # Move o cursor para a quarta linha
	call write_arrow # Escreve a seta que seleciona o menu
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x34 # Caractere "4"
	call write # Escreve o valor armazendo no registrador de r16
	call write # Repete a escrita pois o display tem mania de ignorar o último caractere
	call loop_four # Chama a label que contém o loop que irá esperar por comandos dos botões do quinto estado


# -------------------------------------------------  LOOPS PARA CADA ESTADO --------------------------------------------------- #
loop_zero:
	movia r18, 0x7 # Move o valor 0X7 para r18, o qual é usado para acender o led correspondente a opção do menu
	ldbio r4, 0(r2) # Carrega o valor do button em r4
	movia r15, 0x7 # Usa o registrador r15 para carregar os valores que serão comparados para branch
	beq r4, r15, state_one # Caso o botão de descer a seleção seja selecionado, dá branch para o estado 1
	movia r15, 0xD # Usa o registrador r15 para carregar os valores que serão comparados para branch
	beq r4, r15, leds_on # Caso o botão de selecionar seja apertado, dá branch para a função que acenderá o led correspondente
	br loop_zero # Caso seja nenhuma ou uma combinação errada seja selecionada, ele volta a esperar


loop_one:
	movia r18, 0xB # Move o valor 0XB para r18, o qual é usado para acender o led correspondente a opção do menu
	ldbio r4, 0(r2) # Carrega o valor do button em r4
	movia r15, 0x7 # Usa o registrador r15 para carregar os valores que serão comparados para branch
	beq r4, r15, state_two # Caso o botão de descer a seleção seja selecionado, dá branch para o estado 2
	movia r15, 0xB # Usa o registrador r15 para carregar os valores que serão comparados para branch
	beq r4, r15, state_zero # Caso o botão de subir a seleção seja selecionado, dá branch para o estado 0
	movia r15, 0xD # Usa o registrador r15 para carregar os valores que serão comparados para branch
	beq r4, r15, leds_on # Caso o botão de selecionar seja apertado, dá branch para a função que acenderá o led correspondente
	br loop_one # Caso seja nenhuma ou uma combinação errada seja selecionada, ele volta a esperar


loop_two:
	movia r18, 0xD # Move o valor 0XD para r18, o qual é usado para acender o led correspondente a opção do menu
	ldbio r4, 0(r2) # Carrega o valor do button em r4
	movia r15, 0x7 # Usa o registrador r15 para carregar os valores que serão comparados para branch
	beq r4, r15, state_three # Caso o botão de descer a seleção seja selecionado, dá branch para o estado 3
	movia r15, 0xB # Usa o registrador r15 para carregar os valores que serão comparados para branch
	beq r4, r15, state_one # Caso o botão de subir a seleção seja selecionado, dá branch para o estado 1
	movia r15, 0xD # Usa o registrador r15 para carregar os valores que serão comparados para branch
	beq r4, r15, leds_on # Caso o botão de selecionar seja apertado, dá branch para a função que acenderá o led correspondente
	br loop_two # Caso seja nenhuma ou uma combinação errada seja selecionada, ele volta a esperar


loop_three:
	movia r18, 0xE # Move o valor 0XE para r18, o qual é usado para acender o led correspondente a opção do menu
	ldbio r4, 0(r2) # Carrega o valor do button em r4
	movia r15, 0x7 # Usa o registrador r15 para carregar os valores que serão comparados para branch
	beq r4, r15, state_four # Caso o botão de descer a seleção seja selecionado, dá branch para o estado 4
	movia r15, 0xB # Usa o registrador r15 para carregar os valores que serão comparados para branch
	beq r4, r15, state_two # Caso o botão de subir a seleção seja selecionado, dá branch para o estado 2
	movia r15, 0xD # Usa o registrador r15 para carregar os valores que serão comparados para branch
	beq r4, r15, leds_on # Caso o botão de selecionar seja apertado, dá branch para a função que acenderá o led correspondente
	br loop_three # Caso seja nenhuma ou uma combinação errada seja selecionada, ele volta a esperar


loop_four:
	movia r18, 0xC # Move o valor 0XC para r18, o qual é usado para acender o led correspondente a opção do menu
	ldbio r4, 0(r2) # Carrega o valor do button em r4
	movia r15, 0xB # Usa o registrador r15 para carregar os valores que serão comparados para branch
	beq r4, r15, state_three # Caso o botão de subir a seleção seja selecionado, dá branch para o estado 3
	movia r15, 0xD # Usa o registrador r15 para carregar os valores que serão comparados para branch
	beq r4, r15, leds_on # Caso o botão de selecionar seja apertado, dá branch para a função que acenderá o led correspondente
	br loop_four # Caso seja nenhuma ou uma combinação errada seja selecionada, ele volta a esperar


# -------------------------------------------------  ACENDER LED CORRESPONDENTE --------------------------------------------------- #
leds_on: 
	stbio r18, 0(r3) # Armazena nos leds (r3) o valor de r18, ou seja, acende o led escolhido
	movia r15, 0xE # Armazena em r15 o valor 0XE, usado para verificar se o botão de "voltar" foi selecionado
	call write_doll # Chama label que mostra a mensagem referente a opção selecionada
	led_loop: # Loop que aguarda o botão de voltar ser selecionado
		ldbio r4, 0(r2) # Carrega o estado dos botões em r4
	 	bne r4, r15, led_loop # Verifica se o botão de voltar foi selecionado. Se sim, sai do loop. Se não, continua
	call turn_led_off # Chama função que desliga todos os leds
	movia r20, 0x30 # Move para r20 o valor do estado 0
	beq r19, r20, state_zero # Caso a máquina se encontre no estado zero, volta pra o menu com "Menu 0" selecionado
	movia r20, 0x31 # Move para r20 o valor do estado 1
	beq r19, r20, state_one # Caso a máquina se encontre no estado zero, volta pra o menu com "Menu 1" selecionado
	movia r20, 0x32 # Move para r20 o valor do estado 2
	beq r19, r20, state_two # Caso a máquina se encontre no estado zero, volta pra o menu com "Menu 2" selecionado
	movia r20, 0x33 # Move para r20 o valor do estado 3
	beq r19, r20, state_three # Caso a máquina se encontre no estado zero, volta pra o menu com "Menu 3" selecionado
	movia r20, 0x34 # Move para r20 o valor do estado 4
	beq r19, r20, state_four # Caso a máquina se encontre no estado zero, volta pra o menu com "Menu 4" selecionado


# ----------------------------------------------  ESCREVE O QUE HÁ EM R16 NO LCD ------------------------------------------------- #
write: 
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	custom 0, r23, r17, r16 # Envia dado armazenado em R16 para ser escrito
	call delay_0_053ms # Delay de 0.053ms
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label


# ------------------------------------------  REALIZA UM SHIFT DE 2 ESPAÇOS A DIREITA -------------------------------------------- #
shift_write:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	movia r16, 0x20 # Dá um espaço no que tá escrito no Display
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x20 # Dá um espaço no que tá escrito no Display
	call write # Escreve o valor armazendo no registrador de r16
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label


# ---------------------------------------------  ESCREVE A PALAVRA "Menu" NO DISPLAY ----------------------------------------------- #
write_menu: 
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	movia r16, 0x4D # Caractere "M"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x65 # Caractere "e"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x6E # Caractere "n"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x75 # Caractere "u"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazendo no registrador de r16
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label


# -------------------------------------------------  LIMPA O DISPLAY --------------------------------------------------- #
clear_lcd:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	movia r17, 0x0 # Mudando PINRS para envio de instruções
	movia r16, 0x01 # Código para limpar LCD
	call delay_0_053ms # Delay de 0.053ms
	custom 0, r23, r17, r16 # Limpando LCD
	movia r17, 0x1 # Mudando PINRS para envio de dados
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label


# -------------------------------------------------  ESCREVE UMA SETA NO LCD --------------------------------------------------- #
write_arrow:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x3E # Caractere ">"
	call write # Escreve o valor armazendo no registrador de r16
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label


# -------------------------------------------------  DESLIGA TODOS OS LEDS --------------------------------------------------- #
turn_led_off:
	movia r18, 0XF # Coloca o valor 0XF em r18, para desligar os leds
	stbio r18, 0(r3) # Carrega nos leds o valor para deixá-los off
	ret # Retorna para a rotina que chamou essa label


# ----------------------------------------  DESENHA A MENSAGEM PARA A OPÇÃO ESCOLHIDA ------------------------------------------ #
write_doll:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	call clear_lcd
# ----------- Linha 1
	call line_one # Chama a função para ir para a linha inicial
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
# ----------- Linha 2
	call line_two # Move o cursor para a segunda linha
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x7C # Caractere "|"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x56 # Caractere "V"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x6F # Caractere "o"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x63 # Caractere "c"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x65 # Caractere "e"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x73 # Caractere "s"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x65 # Caractere "e"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x6C # Caractere "l"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x65 # Caractere "e"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x63 # Caractere "c"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x69 # Caractere "i"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x6F # Caractere "o"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x6E # Caractere "n"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x6F # Caractere "o"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x75 # Caractere "u"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x7C # Caractere "|"
	call write # Escreve o valor armazendo no registrador de r16
# ----------- Linha 3
	call line_three # Move o cursor para a terceira linha
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x7C # Caractere "|"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x61 # Caractere "a"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x6F # Caractere "o"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x70 # Caractere "p"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x63 # Caractere "c"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x61 # Caractere "a"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x6F # Caractere "o"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazendo no registrador de r16
	call write_state_numer  # Chama função que escreve o número referente ao estado onde a máquina se encontra
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x7C # Caractere "|"
	call write # Escreve o valor armazendo no registrador de r16
# ----------- Linha 4
	call line_four # Move o cursor para a quarta linha
	movia r16, 0x20 # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x20 # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazendo no registrador de r16
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label


# ----------------------------------------  ESCREVE O Nº DO ESTADO ONDE A MÁQUINA ESTÁ ------------------------------------------ #
write_state_numer:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	custom 0, r23, r17, r19 # Envia dado armazenado em R16 para ser escrito
	call delay_0_053ms # Delay de 0.053ms
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label


.end # ----------------------------- FIM DO ARQUIVO