#-------------------------------------------------------------------	
#------ SUBRUTINA: 
#------   * Parametros de entrada: a0 disp_ready_addr a1 disp_register_addr a2 reciber_control_regis a3 stringinput
#------   * Parametros de salida: Ninguno
#-------------------------------------------------------------------
.globl imprimir_resultado
imprimir_resultado:  #-- Punto de entrada

	
	
	li 	t1, '0'
	add	t3, a3, t1  #-- t3 = t0 - '0
	sw	a3, 0(a1)
	
	
	ret
