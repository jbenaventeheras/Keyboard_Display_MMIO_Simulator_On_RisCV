
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

#-------------------------------------------------------------------	
#------ SUBRUTINA: 
#------   * Parametros de entrada: a0 disp_ready_addr a1 disp_register_addr a2 reciber_control_regis a3 stringinput
#------   * Parametros de salida: Ninguno
#-------------------------------------------------------------------
print_string:  #-- Punto de entrada


wait_for_ready:
	# while(ready_bit == 0);
	lw	t0, 0(a0)
	beq	t0, zero, wait_for_ready
	
display_char:
	# Check for null character
	lb	t0, 0(a3)
	beq	t0, zero, end
	
	# Write to display
	sw	t0, 0(a1)
	
	# Increment string pointer
	addi	a3, a3, 1
	j	wait_for_ready
	
	

end:
	ret


#-------------------------------------------------------------------	
#------ SUBRUTINA: read_keyboard
#------   * Parametros de entrada: a0 disp_ready_addr a1 disp_register_addr a2 reciber_control_regis a3 keystroke_text_area
#------   * Parametros de salida: a0 char read
#-------------------------------------------------------------------
read_keyboard:  #-- Punto de entrada

	
	# esperar a que se ponga a 1 al introducir numero
	lw	t1, 0(a2)
	beq	t1, zero, read_keyboard
	lb	t0, 0(a3)
	mv 	a0, t0
	
	ret
#-------------------------------------------------------------------	
#------ SUBRUTINA: check_char
#------   * Parametros de entrada: a0 char1 a1: char2
#------   * Parametros de salida: a0 1 if equal 0 if not equal in ascci table 0x00000030 0x00000031
#-------------------------------------------------------------------
check_char:  #-- Punto de entrada
	   
	   
	   beq	a0, a1, equal
	   li a0, 0x00000030
	   
equal:	   
	   li a0, 0x00000031
	   
	   ret
	   
	   
