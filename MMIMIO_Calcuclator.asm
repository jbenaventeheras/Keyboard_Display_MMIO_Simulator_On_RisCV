.include "servicios_mmio.asm"

.eqv primer_digito 0x00000039 #9
.eqv segundo_digito 0x00000035 #5
.eqv tercer_digito 0x00000037 #4


.data



string:		.asciz "-INTRODUCE PRIMER DIGITO \n"
string2:	.asciz "LANZAMIENTO INICIADO   - ~~~ =:> [XXXXXXXXX]> \n"
string3:	.asciz "LANZAMIENTO FALLIDO  xxxxxxxxxxxxxxxxx \n"

.text


	
#----------------------------------------------
#-- PROGRAMA PRINCIPAL
#----------------------------------------------

		#imprimir string
		
		li	a0, disp_ready_addr
		li	a1, disp_register_addr
		li 	a2, reciber_control_regis
		la	a3, string
		jal print_string
		
		#leer primer digito
		li	a0, disp_ready_addr
		li	a1, disp_register_addr
		li 	a3, keystroke_text_area
		jal 	read_keyboard
		
		
		
		
		# Terminate
		li	a7, 10
		ecall