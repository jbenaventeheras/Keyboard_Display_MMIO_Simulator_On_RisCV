
.include "servicios_mmio.asm"

.eqv primer_digito 0x00000039
.eqv segundo_digito 0x00000035


.data



string:		.asciz "INTRODUZCA SECUENCIA DESPEGUE \n"
string2:	.asciz "lANZAMIENTO INICIADO \n"

.text

	# s0 <- display ready bit addr
	# s1 <- display register addr
	# s2 <- pointer to string
	
	li	a0, disp_ready_addr
	li	a1, disp_register_addr
	li 	a3, reciber_control_regis
	li 	a4, keystroke_text_area
	la	a2, string
	
#----------------------------------------------
#-- PROGRAMA PRINCIPAL
#----------------------------------------------
	
		jal print_string
		
	

#-------------------------------------------------------------------	
#------ SUBRUTINA: 
#------   * Parametros de entrada: a0 disp_ready_addr a1 disp_register_addr a3 reciber_control_regis
#------   * Parametros de salida: Ninguno
#-------------------------------------------------------------------
print_string:  #-- Punto de entrada


wait_for_ready:
	# while(ready_bit == 0);
	lw	t0, 0(a0)
	beq	t0, zero, wait_for_ready
	
display_char:
	# Check for null character
	lb	t0, 0(a2)
	beq	t0, zero, end
	
	# Write to display
	sw	t0, 0(a1)
	
	# Increment string pointer
	addi	a2, a2, 1
	j	wait_for_ready
	
	

end:
	ret