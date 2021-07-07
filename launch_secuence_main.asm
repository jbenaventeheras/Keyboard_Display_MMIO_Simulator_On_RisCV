.include "servicios_mmio.asm"

.eqv primer_digito 0x00000039
.eqv segundo_digito 0x00000035


.data



string:		.asciz "INTRODUZCA SECUENCIA DESPEGUE \n"
string2:	.asciz "lANZAMIENTO INICIADO \n"
string3:	.asciz "lANZAMIENTO FALLIDO \n"

.text

	# s0 <- display ready bit addr
	# s1 <- display register addr
	# s2 <- pointer to string
	
	
#----------------------------------------------
#-- PROGRAMA PRINCIPAL
#----------------------------------------------

		#imprimir string
		
		li	a0, disp_ready_addr
		li	a1, disp_register_addr
		li 	a2, reciber_control_regis
		la	a3, string
		jal print_string
		
		#leer primer caracter contraseña
		li	a0, disp_ready_addr
		li	a1, disp_register_addr
		li 	a3, keystroke_text_area
		jal 	read_keyboard
		
		#comprobar primer caracter constraseña
		li, a1,  primer_digito
		jal check_char
		
		#si priner caracter incorrecto imprimimos despegue cancelado y terminamos si correcto continuamos
		li  t0, 0x00000030
		beq t0, a0, fail_check
		
		#leer segundo caracter contraseña
		li	a0, disp_ready_addr
		li	a1, disp_register_addr
		li 	a3, keystroke_text_area
		jal 	read_keyboard
		
		#comprobar segundo caracter constraseña
		li, a1,  segundo_digito
		jal check_char
		
		#si segundo caracter incorrecto imprimimos despegue cancelado y terminamos si correcto imprimir launch
		li  t0, 0x00000030
		beq t0, a0, fail_check
		
		li	a0, disp_ready_addr
		li	a1, disp_register_addr
		li 	a2, reciber_control_regis
		la	a3, string2
		jal 	print_string
		
		li	a7, 10
		ecall

		
fail_check:
		li	a0, disp_ready_addr
		li	a1, disp_register_addr
		li 	a2, reciber_control_regis
		la	a3, string3
		jal print_string		
		
		# Terminate
		li	a7, 10
		ecall