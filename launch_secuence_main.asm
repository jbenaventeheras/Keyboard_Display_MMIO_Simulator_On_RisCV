.include "servicios_mmio.asm"

.eqv primer_digito 0x00000039 #9
.eqv segundo_digito 0x00000035 #5
.eqv tercer_digito 0x00000037 #4


.data



string:		.asciz "---------INTRODUZCA SECUENCIA DESPEGUE------- \n"
string2:	.asciz "LANZAMIENTO INICIADO   - ~~~ =:> [XXXXXXXXX]> \n"
string3:	.asciz "LANZAMIENTO FALLIDO  xxxxxxxxxxxxxxxxx \n"

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
		la	a2, string	
		jal 	print_string
		
		#leer primer caracter contraseña
		li 	a0, reciber_control_regis
		li 	a1, keystroke_text_area
		jal read_keyboard
		
		
		#guardamos primer digito en s0
		mv s0, a0,
		
		#Comprobar si primer digito correcto si no abortar lanzamiento
		li t1, primer_digito
		bne, s0, t1, fail_check
		
		#leer segundo caracter contraseña
		li 	a0, reciber_control_regis
		li 	a1, keystroke_text_area
		jal read_keyboard
		
		mv s1, a0
		
		#Comprobar si primer digito correcto si no abortar lanzamiento
		li t1, segundo_digito
		bne, s1, t1, fail_check
		
		
		#leer tercer caracter contraseña
		li 	a0, reciber_control_regis
		li 	a1, keystroke_text_area
		jal 	read_keyboard
		
		mv s2, a0
		
		#Comprobar si tercer digito correcto si no abortar lanzamiento
		li t1, tercer_digito
		bne, s2, t1, fail_check
		
		
		#imprimir string de lanzamineto en este punto todos digitos correctos
		li	a0, disp_ready_addr
		li	a1, disp_register_addr
		la	a2, string2
		jal 	print_string
		
		jal end
	
		
			
fail_check:

		li	a0, disp_ready_addr
		li	a1, disp_register_addr
		la	a2, string3	
		jal 	print_string	
end:		
		# Terminate
		li	a7, 10
		ecall
