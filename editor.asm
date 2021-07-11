.include "servicios_mmio.asm"



.data




.text


	
#----------------------------------------------
#-- PROGRAMA PRINCIPAL
#----------------------------------------------

	
		#leer primer caracter contraseña
		li	a0, disp_ready_addr
		li	a1, disp_register_addr
		li 	a2, reciber_control_regis
		li 	a3, keystroke_text_area
		li s1,  '0'
		li s2,  0
bucle:
		#imprimir string
	
		
		jal read_keyboard
		mv s0, a0
		sw	s0, 0(a1)
		
		addi s2, s2, 1
		mv a0, s2
		li  a7, 1 
		ecall
		
		beq s0, s1, final
		b bucle
	
final:		 

		
		# Terminate
		li	a7, 10
		ecall