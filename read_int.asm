#-------------------------------------------------------------------	
#------ SUBRUTINA: read_int
#------   * Parametros de entrada: a0 disp_ready_addr a1 disp_register_addr a2 reciber_control_regis a3 keystroke_text_area
#------   * Parametros de salida: a0 int read
#-------------------------------------------------------------------
.globl read_int
read_int:  #-- Punto de entrada

	
	# esperar a que se ponga a 1 al introducir numero
	lw	t1, 0(a2)
	beq	t1, zero, read_int
	lb	t0, 0(a3)
	
	#-- Obtener el numero del digito (t1 - '0')
	li t1, '0'
	sub t3, t0, t1  #-- t3 = t0 - '0
	
	mv 	a0, t3
	
	ret