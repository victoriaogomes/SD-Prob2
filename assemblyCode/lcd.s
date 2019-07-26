.equ switches, 0x00003030
.equ leds, 0x00003020
.equ delay15ms, 0xF424
.equ delay4_1ms, 0x42BB
.equ delay0_1ms, 0x1A0
.equ delay100ms, 0x65B9A
.equ delay0_053ms, 0xDC
.equ delay1s, 0x3F940B
.equ uart, 0x00002020

# ---------------------------------------------   TEXTO DOS COMANDOS AT -------------------------------------------- #
.equ A, 0x41
.equ T, 0x54
.equ mais, 0x2b
.equ C, 0x43
.equ W, 0x57
.equ M, 0x4D
.equ N, 0x4e
.equ O, 0x4f
.equ D, 0x44
.equ E, 0x45
.equ igual, 0x3d
.equ um, 0x31
.equ J, 0x4a
.equ P, 0x50
.equ S, 0x53
.equ R, 0x52
.equ I, 0x49
.equ aspas, 0x22
.equ virgula, 0x2c
.equ H, 0x48

.global _start


# ------------------------------------------------   FUNÇÃO PRINCIPAL ----------------------------------------------- #
_start:
	movia r2, switches # Move para r2 o endereço dos switches
	movia r3, leds # Move para r3 o endereço dos leds
	movia r5, uart # Move para r5 o endereço base da uart
	movia r9, 0x0 # Contador utilizado nos delays, inicializado em 0
	call turn_led_off # Chama a função que desligará todos os leds
	call initialize_lcd # Chama a função que inicializa o LCD
	call send_ATCommand0 # Chama função para configurar o ESP8266 no modo de comandos AT
	call delay_1s # Chama delay de 1s
	call read_uart # Chama função que faz a leitura da UART
	call send_ATCommand1 # Chama função para configurar o ESP8266 no modo de comandos AT
	call delay_1s # Chama delay de 1s
	call read_uart # Chama função que faz a leitura da UART
	call send_ATCommand2 # Chama função para configurar o ESP8266 no modo de comandos AT
	call delay_1s # Chama delay de 1s
	call read_uart # Chama função que faz a leitura da UART
	call state_zero # Chama a função state_zero, começando a execução da máquina de estados


# ----------------------------------------------   CONFIGURAÇÃO DO ESP --------------------------------------------- #
send_ATCommand0:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
##########################DEBUG
#	movia r17, 0x1
#	call delay_0_1ms # Delay de 0.1ms
#	movia r16, A
#	call delay_0_1ms # Delay de 0.1ms
#	custom 0, r23, r17, r16 # Definindo function set do LCD
#	call delay_15ms
########################FIM DEBUG
	movia r21, A # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "A" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, T # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "T" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label

send_ATCommand1:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	call send_ATCommand0 # Envia "AT" ao ESP8266
	movia r21, mais # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "+" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, C # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "C" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, W # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "W" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, M # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "M" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, O # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "O" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, D # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "D" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, E # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "E" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, igual # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "=" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, um # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "1" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label

send_ATCommand2:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	call send_ATCommand0 # Envia "AT" ao ESP8266
	movia r21, C # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "C" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, W # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "W" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, J # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "J" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, A # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "A" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, P # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "P" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, igual # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "=" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, aspas # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar aspas ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, W # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "W" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, O # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "O" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, W # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "W" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, aspas # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar aspas ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, virgula # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "," ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, aspas # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar aspas ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, T # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "T" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, A # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "A" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, mais # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "+" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, C # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "C" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, H # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "H" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, A # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "A" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, T # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "T" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, O # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "O" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, aspas # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar aspas ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label

send_ATCommand3:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	call send_ATCommand0 # Chama função que envia "AT" ao ESP8266
	movia r21, mais # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "+" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, C # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "C" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, I # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "I" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, P # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "P" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, S # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "S" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, T # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "T" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, A # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "A" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, R # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "R" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, T # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "T" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, igual # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "=" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, aspas # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar aspas ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, T # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "T" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, C # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "C" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, P # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "P" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, aspas # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar aspas ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, virgula # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "," ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, aspas # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar aspas ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	# Começo do IP
	movia r21, 0x31 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "1" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x39 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "9" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x32 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "2" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x2e # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "." ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x31 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "1" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x36 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "6" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x38 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "8" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x2e # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "." ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x34 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "4" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x33 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "3" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x2e # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "." ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x31 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "1" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x35 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "5" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x32 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "2" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	#Fim do IP
	movia r21, aspas # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar aspas ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, virgula # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "," ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x31 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "1" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x38 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "8" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x38 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "8" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x33 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "3" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label

send_ATCommand4:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	call send_ATCommand0 # Chama função que envia "AT" ao ESP8266
	movia r21, mais # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "+" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, C # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "C" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, I # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "I" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, P # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "P" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, S # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "S" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, E # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "E" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, N # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "N" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, D # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "D" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, igual # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "=" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label

send_MQTT_ConnectPackage:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	call send_ATCommand4 # Chama função que envia "AT+CIPSEND=" ao ESP8266
	movia r21, 0x32 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "2" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x30 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "0" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x10 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar mensagem de conexão MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x12 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o tamanho restante do pacote de conexão MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x00 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar mensagem de configuração MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x04 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar versão do MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x4d # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o caractere "M" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x51 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o caractere "Q" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x54 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o caractere "T" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x54 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o caractere "T" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x04 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar mensagem de configuração MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x02 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar mensagem de configuração MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x00 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar mensagem de configuração MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x14 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar mensagem de configuração MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x00 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar mensagem de configuração MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x06 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar mensagem de configuração MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x4e # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o caractere "N" MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x69 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o caractere "I" MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x6f # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o caractere "O" MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x73 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o caractere "S" MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x20 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o caractere " " MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x32 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o caractere "2" MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label

send_MQTT_DisconnectPackage:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	call send_ATCommand4 # Chama mandar "CIPSEND="
	movia r21, 0x32 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar "2" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0xe0 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar mensagem de desconexão MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x00 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar mensagem de tamanho do pacote MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label

send_MQTT_Message:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	call send_ATCommand4 # Chama mandar "CIPSEND="
	movia r21, um # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o caractere "1" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x30 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o caractere "0" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x30 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar mensagem de publish do pacote MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x8 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o tamanho do pacote MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x00 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar mensagem de configuração do pacote MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x0C # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar mensagem de configuração do pacote MQTT ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, T # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o caractere "T" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, um # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o caractere "1" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, 0x2f # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o caractere "/" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, A # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o caractere "A" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	movia r21, um # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o caractere "1" ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	add r21, r19, r0 # Move para r21 o caractere a ser enviado para o ESP8266
	call write_uart # Chama função para enviar o caractere do estado atual ao ESP8266
	call delay_4_1ms # Chama delay de 4.1ms
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label


# --------------------------------------------   INICIALIZAÇÃO DO LCD ----------------------------------------------- #
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
	movia r8, delay15ms # Armazena o valor usado para o delay de 15ms em r8
	loop15ms:
		addi r9, r9, 1 # Adiciona 1 no registrador r9
		bne r9, r8, loop15ms # Verifica se r9 armazena mesmo valor que r8 (se não, volta pro início do looping)
		addi r9, r0, 0 # Zera o registrador r9
	ret

delay_4_1ms:
	movia r8, delay4_1ms # Armazena o valor usado para o delay de 4.1ms em r8
	loop4_1ms:
		addi r9, r9, 1 # Adiciona 1 no registrador r9
		bne r9, r8, loop4_1ms # Verifica se r9 armazena mesmo valor que r8 (se não, volta pro início do looping)
		addi r9, r0, 0 # Zera o registrador r9
	ret

delay_0_1ms:
	movia r8, delay0_1ms # Armazena o valor usado para o delay de 0.1ms em r8
	loop0_1ms:
		addi r9, r9, 1 # Adiciona 1 no registrador r9
		bne r9, r8, loop0_1ms # Verifica se r9 armazena mesmo valor que r8 (se não, volta pro início do looping)
		addi r9, r0, 0 # Zera o registrador r9
	ret

delay_100ms:
	movia r8, delay100ms # Armazena o valor usado para o delay de 100ms em r8
	loop100ms:
		addi r9, r9, 1 # Adiciona 1 no registrador r9
		bne r9, r8, loop100ms # Verifica se r9 armazena mesmo valor que r8 (se não, volta pro início do looping)
		addi r9, r0, 0 # Zera o registrador r9
	ret

delay_1s:
	movia r8, delay1s # Armazena o valor usado para o delay de 1s em r8
	loop1s:
		addi r9, r9, 1 # Adiciona 1 no registrador r9
		bne r9, r8, loop1s # Verifica se r9 armazena mesmo valor que r8 (se não, volta pro início do looping)
		addi r9, r0, 0 # Zera o registrador r9
	ret

delay_0_053ms:
	movia r8, delay0_053ms # Armazena o valor usado para o delay de 0.053ms em r8
	loop0_053ms:
		addi r9, r9, 1 # Adiciona 1 no registrador r9
		bne r9, r8, loop0_053ms # Verifica se r9 armazena mesmo valor que r8 (se não, volta pro início do looping)
		addi r9, r0, 0 # Zera o registrador r9
	ret

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
	movia r19, 0x31 # Salva em r19 que a máquina se encontra no estado 1
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
	call write # Escreve o valor armazenado no registrador de r16
	call write # Repete a escrita pois o display tem mania de ignorar o último caractere
	call loop_one # Chama a label que contém o loop que irá esperar por comandos dos botões do segundo estado

state_two: # Terceiro estado da máquina, as quatro primeiras opções do display com a terceira sendo destacada
	movia r19, 0x32 # Salva em r19 que a máquina se encontra no estado 2
	call clear_lcd # Limpa o display
	call line_one # Move o cursor para a primeira linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x30 # Caractere "0"
	call write # Escreve o valor armazenado no registrador de r16
	call line_two # Move o cursor para a segunda linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x31 # Caractere "1"
	call write # Escreve o valor armazenado no registrador de r16
	call line_three # Move o cursor para a terceira linha
	call write_arrow # Escreve a seta que seleciona o menu
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x32 # Caractere "2"
	call write # Escreve o valor armazenado no registrador de r16
	call line_four # Move o cursor para a quarta linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x33 # Caractere "3"
	call write # Escreve o valor armazenado no registrador de r16
	call write # Repete a escrita pois o display tem mania de ignorar o último caractere
	call loop_two # Chama a label que contém o loop que irá esperar por comandos dos botões do terceiro estado

state_three: # Quarto estado da máquina, as quatro primeiras opções do display com a quarta sendo destacada
	movia r19, 0x33 # Salva em r19 que a máquina se encontra no estado 3
	call clear_lcd # Limpa o display
	call line_one # Move o cursor para a primeira linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x30 # Caractere "0"
	call write # Escreve o valor armazenado no registrador de r16
	call line_two # Move o cursor para a segunda linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x31 # Caractere "1"
	call write # Escreve o valor armazenado no registrador de r16
	call line_three # Move o cursor para a terceira linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x32 # Caractere "2"
	call write # Escreve o valor armazenado no registrador de r16
	call line_four # Move o cursor para a quarta linha
	call write_arrow # Escreve a seta que seleciona o menu
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x33 # Caractere "3"
	call write # Escreve o valor armazenado no registrador de r16
	call write # Repete a escrita pois o display tem mania de ignorar o último caractere
	call loop_three # Chama a label que contém o loop que irá esperar por comandos dos botões do quarto estado

state_four: # Quinto estado da máquina, as quatro primeiras opções do display com a quinta sendo destacada
	movia r19, 0x34 # Salva em r19 que a máquina se encontra no estado 4
	call clear_lcd # Limpa o display
	call line_one # Move o cursor para a primeira linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x31 # Caractere "1"
	call write # Escreve o valor armazenado no registrador de r16
	call line_two # Move o cursor para a segunda linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x32 # Caractere "2"
	call write # Escreve o valor armazenado no registrador de r16
	call line_three # Move o cursor para a terceira linha
	call shift_write # Da um shift a direita de 2 espaços
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x33 # Caractere "3"
	call write # Escreve o valor armazenado no registrador de r16
	call line_four # Move o cursor para a quarta linha
	call write_arrow # Escreve a seta que seleciona o menu
	call write_menu # Escreve a palavra "Menu"
	movia r16, 0x34 # Caractere "4"
	call write # Escreve o valor armazenado no registrador de r16
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
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x20 # Dá um espaço no que tá escrito no Display
	call write # Escreve o valor armazenado no registrador de r16
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label


# ---------------------------------------------  ESCREVE A PALAVRA "Menu" NO DISPLAY ----------------------------------------------- #
write_menu:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	movia r16, 0x4D # Caractere "M"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x65 # Caractere "e"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x6E # Caractere "n"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x75 # Caractere "u"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazenado no registrador de r16
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
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x3E # Caractere ">"
	call write # Escreve o valor armazenado no registrador de r16
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
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
# ----------- Linha 2
	call line_two # Move o cursor para a segunda linha
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x7C # Caractere "|"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x56 # Caractere "V"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x6F # Caractere "o"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x63 # Caractere "c"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x65 # Caractere "e"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x73 # Caractere "s"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x65 # Caractere "e"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x6C # Caractere "l"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x65 # Caractere "e"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x63 # Caractere "c"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x69 # Caractere "i"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x6F # Caractere "o"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x6E # Caractere "n"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x6F # Caractere "o"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x75 # Caractere "u"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x7C # Caractere "|"
	call write # Escreve o valor armazenado no registrador de r16
# ----------- Linha 3
	call line_three # Move o cursor para a terceira linha
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x7C # Caractere "|"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x61 # Caractere "a"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x6F # Caractere "o"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x70 # Caractere "p"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x63 # Caractere "c"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x61 # Caractere "a"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x6F # Caractere "o"
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazenado no registrador de r16
	call write_state_number  # Chama função que escreve o número referente ao estado onde a máquina se encontra
	movia r16, 0x20 # Caractere espaço em branco
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x7C # Caractere "|"
	call write # Escreve o valor armazenado no registrador de r16
# ----------- Linha 4
	call line_four # Move o cursor para a quarta linha
	movia r16, 0x20 # Caractere " "
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	movia r16, 0x2D # Caractere "-"
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	call write # Escreve o valor armazenado no registrador de r16
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label


# ----------------------------------------  ESCREVE O Nº DO ESTADO ONDE A MÁQUINA ESTÁ ------------------------------------------ #
write_state_number:
	addi r27, r27, -4 # Aloca espaço na pilha
	stw r31, 0(r27) # Salva na pilha o endereço para o qual deverá voltar após executar os procedimetos seguintes
	custom 0, r23, r17, r19 # Envia dado armazenado em R19 para ser escrito
	call delay_0_053ms # Delay de 0.053ms
	call send_ATCommand3 # Chama função para configurar o ESP8266 no modo de comandos AT
	call delay_1s # Chama delay de 1s
	call read_uart # Chama função que faz a leitura da UART
	call send_MQTT_ConnectPackage
	call send_MQTT_Message # Manda a mensagem MQTT para o ESP8266
	call send_MQTT_DisconnectPackage
	ldw r31, 0(r27) # Colocando o endereço para o qual deve voltar no registrador r31
	addi r27, r27, 4 # Desalocando espaço na pilha
	ret # Retorna para a rotina que chamou essa label

# -------------------------------- MANDA r21 PRA UART --------------------------------------------------------------------------- #
write_uart:
	put_char:
		ldwio r22, 4(r5) # Lê o registrador de controle do JTAG UART, armazenado em r5 
		andhi r22, r22, 0xffff # Checa se existe espaço pra escrever 
		beq r22, r0, end_put # Se não há espaço, não escreve 
		stwio r21, 0(r5) # Se há espaço, manda o caractere 
	end_put:
	ret

# -------------------------------- LÊ r12 DA UART --------------------------------------------------------------------------- #
read_uart:
	get_char:
		ldwio r12, 0(r5) # Lê o registrador de controle do JTAG UART, armazenado em r5 
		andi r13, r12, 0x8000 # Checa se chegou algum dado novo 
		bne r13, r0, return_char # Se chegou, irá ler na função return_char 
		mov r12, r0 # Se não chegou, retornará ‘\0’ 
	return_char: # Retorna o caractere a ser lido em seguida 
		andi r13, r12, 0x00ff # O dado novo estará no bit menos significativo 
		mov r12, r13 # Coloco em r12 o dado que preciso retornar 
	ret

.end # ----------------------------- FIM DO ARQUIVO
