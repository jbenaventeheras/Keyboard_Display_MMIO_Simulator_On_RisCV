#-------------------------------------------------------------------	
#------ SUBRUTINA: read_keyboard
#------   * Parametros de entrada: a0 disp_ready_addr a1 disp_register_addr a2 reciber_control_regis a3 keystroke_text_area
#------   * Parametros de salida: a0 char read
#-------------------------------------------------------------------
.globl multiplicar
multiplicar:  #-- Punto de entrada

	
	# esperar a que se ponga a 1 al introducir numero
	mul t0, a0, a1
	mv  a0, t0
	
	ret
