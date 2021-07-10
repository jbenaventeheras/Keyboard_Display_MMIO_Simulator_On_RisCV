.include "servicios_mmio.asm"


.eqv exit_cons 0x00000030

.data



string:	.asciz "Hello MIMMIO SIMULATOR \n"

.text


	li	a0, disp_ready_addr
	li	a1, disp_register_addr
	li 	a2, reciber_control_regis
	li 	a3, keystroke_text_area
	li      s0, 0
	
read_keyboard:
	
	# esperar a que se ponga a 1 al introducir numero
	lw	t1, 0(a2)
	beq	t1, zero, read_keyboard
	#contador pulsaciones en s0 al salir este bucle incrementamos
	addi 	s0, s0,1
	
	
	
	
	lw	t0, 0(a3)
	li	t2, exit_cons
	beq	t0, t2, exit
	b read_keyboard
	
	

	
exit:



	li	a7, 10
	ecall
