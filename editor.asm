.include "servicios_mmio.asm"

.eqv op_suma 0x0000002b #+
.eqv op_mult 0x00000078 # x
.eqv op_div 0x0000002f # /
.eqv segundo_digito 0x00000035 #5
.eqv tercer_digito 0x00000037 #4


.data



string:		.asciz "-INTRODUC1E PRIMER DIGITO \n"
string2:	.asciz "INTRODUCE SEGUNDO DIGITO \n"
string3:	.asciz "INTRODUCE OPRENDO * x / \n"

.text


	
#----------------------------------------------
#-- PROGRAMA PRINCIPAL
#----------------------------------------------
bucle:
		#imprimir string
		
		#leer primer caracter contraseña
		li	a0, disp_ready_addr
		li	a1, disp_register_addr
		li 	a2, reciber_control_regis
		li 	a3, keystroke_text_area
		
		jal read_keyboard
		bne s0, zero
		sb	s0, 0(s1)
	
		 
		# Terminate
		li	a7, 10