#-------------------------------------------------------------------	
#------ SUBRUTINA: 
#------   * Parametros de entrada: a0 disp_ready_addr a1 disp_register_addr a2 reciber_control_regis a3 stringinput
#------   * Parametros de salida: Ninguno
#-------------------------------------------------------------------

.globl print_string

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