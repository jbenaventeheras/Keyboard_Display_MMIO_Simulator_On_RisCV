.include "servicios_mmio.asm"

.data



string:	.asciz "5"

.text
setup:
	# s0 <- display ready bit addr
	# s1 <- display register addr
	# s2 <- pointer to string
	
	li	s0, disp_ready_addr
	li	s1, disp_register_addr
	li 	s3, reciber_control_regis
	li	s2, 1
	

	
display_char:
	# Check for null character
	lb	t0, 0(s2)
	
	
	# Write to display
	sw	s2, 0(s1)
	
	# Increment string pointer
	
	
end_of_string:
	# Terminate
	li	a7, 10
	ecall
