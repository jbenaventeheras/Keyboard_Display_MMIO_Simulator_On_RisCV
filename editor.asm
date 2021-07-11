.include "servicios_mmio.asm"



.data




.text


	
#----------------------------------------------
#-- PROGRAMA PRINCIPAL
#----------------------------------------------
					#leer primer caracter contraseña
		li	s1, disp_register_addr
		li s3,  '0'
		
bucle:
		
		
		
		li 	a0, reciber_control_regis
		li 	a1, keystroke_text_area
		jal read_keyboard
		
		
		sw	a0, 0(s1)
		beq a0, s3, final
		
		
		
		
		
		addi s2, s2, 1
		mv a0, s2
		li  a7, 1 
		ecall
		b bucle
		
	
final:		 

		
		# Terminate
		li	a7, 10
		ecall
