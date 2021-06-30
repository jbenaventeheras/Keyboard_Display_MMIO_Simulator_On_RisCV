.include "servicios_mmio.asm"

.data



string:	.asciz "Hello MIMMIO SIMULATOR \n"

.text
setup:
	# s0 <- display ready bit addr
	# s1 <- display register addr
	# s2 <- pointer to string
	
	li	t0, disp_ready_addr
	lw	s0, 0(t0)
	li	t0, disp_register_addr
	lw	s1, 0(t0)
	la	s2, string
	
wait_for_ready:
	# while(ready_bit == 0);
	lw	t0, 0(s0)
	beq	t0, zero, wait_for_ready
	
display_char:
	# Check for null character
	lb	t0, 0(s2)
	beq	t0, zero, end_of_string
	
	# Write to display
	sw	t0, 0(s1)
	
	# Increment string pointer
	addi	s2, s2, 1
	j	wait_for_ready
	
end_of_string:
	# Terminate
	li	a7, 10
	ecall
