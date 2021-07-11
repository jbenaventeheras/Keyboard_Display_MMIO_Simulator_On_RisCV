#-------------------------------------------------------------------	
#------ SUBRUTINA: 
#------   * Parametros de entrada: a0 disp_ready_addr a1 disp_register_addr a2 stringinput
#------   * Parametros de salida: Ninguno
#-------------------------------------------------------------------

.globl print_string

print_string:  #-- Punto de entrada


wait_for_ready:
	# while(ready_bit == 0);
	lw	t0, 0(a0)
	beq	t0, zero, wait_for_ready
	
display_char:

	# Check  null char
	lb	t0, 0(a2)
	beq	t0, zero, end
	
	# Write display
	sw	t0, 0(a1)
	
	# Increment str pointer
	addi	a2, a2, 1
	j	wait_for_ready
	
	

end:
	ret
