.include "servicios_mmio.asm"

.data



string:	.asciz "INTRODUZCA SECUENCIA DESPEGUE \n"

.text
setup:
	# s0 <- display ready bit addr
	# s1 <- display register addr
	# s2 <- pointer to string
	
	li	s0, disp_ready_addr
	li	s1, disp_register_addr
	li 	s3, reciber_control_regis
	li 	s4, keystroke_text_area

	la	s2, string
	
start_read:

	
	lb	t0, 0(s4)
	
	
	lw	t1, 0(s3)
	beq	t1, zero, start_read

	# Terminate
	li	a7, 10
	ecall