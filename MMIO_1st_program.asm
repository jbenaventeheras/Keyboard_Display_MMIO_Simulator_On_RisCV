.include "servicios_mmio.asm"

.data



string:	.asciz "Hello MIMMIO SIMULATOR \n"

.text
setup:
	# s0 <- display ready bit addr
	# s1 <- display register addr
	# s2 <- pointer to string
	
	li	s0, keystroke_text_area
	li	s1, disp_register_addr
	li 	s3, reciber_control_regis
	li 	s4, keystroke_text_area
	
	lb	t0, 0(s0)
	sw	t0, 0(s1)
	
	li	a7, 10
	ecall
