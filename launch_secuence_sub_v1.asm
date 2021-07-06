
.include "servicios_mmio.asm"

.eqv primer_digito 0x00000039
.eqv segundo_digito 0x00000035


.data



string:		.asciz "INTRODUZCA SECUENCIA DESPEGUE \n"
string2:	.asciz "lANZAMIENTO INICIADO \n"

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
	
wait_for_ready:
	# while(ready_bit == 0);
	lw	t0, 0(s0)
	beq	t0, zero, wait_for_ready
	
display_char:
	# Check for null character
	lb	t0, 0(s2)
	beq	t0, zero, start_read
	
	# Write to display
	sw	t0, 0(s1)
	
	# Increment string pointer
	addi	s2, s2, 1
	j	wait_for_ready
	
start_read:

primerdigito:	
		

	
	# esperar a que se ponga a 1 al introducir numero
	lw	t1, 0(s3)
	beq	t1, zero, start_read
	
	# comprobar primer digito clave
	lb	t0, 0(s4)
	li 	t1, primer_digito
	bne     t0, t1, primerdigito
	
segundodigito:	
		

	
	
	# comprobar primer digito clave
	lb	t0, 0(s4)
	li 	t1, segundo_digito
	bne     t0, t1, segundodigito


	la	s2, string2
wait_for_ready2:
	# while(ready_bit == 0);
	lw	t0, 0(s0)
	beq	t0, zero, wait_for_ready2
	
display_char2:
	# Check for null character
	lb	t0, 0(s2)
	beq	t0, zero, end
	
	# Write to display
	sw	t0, 0(s1)
	
	# Increment string pointer
	addi	s2, s2, 1
	j	wait_for_ready2	

end:
	# Terminate
	li	a7, 10
	ecall
