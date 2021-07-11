#-------------------------------------------------------------------	
#------ SUBRUTINA: read_keyboard
#------   * Parametros de entrada: a0 reciber_control_regis a1 keystroke_text_area
#------   * Parametros de salida: a0 char read
#-------------------------------------------------------------------
.globl read_keyboard

read_keyboard:  #-- Punto de entrada

	
	# esperar a que se ponga a 1 al introducir numero
	lw	t1, 0(a0)
	beq	t1, zero, read_keyboard
	lb	t0, 0(a1)
	mv 	a0, t0
	
	ret
