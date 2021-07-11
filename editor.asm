.include "servicios_mmio.asm"

.data

string:		.asciz "---------bBIENVENIDO AL EDITOR MMIO ESCRIBA PARA MOSTRAR EN DIPLAY 0 SALIR------ \n"

.text
	
#----------------------------------------------
#-- PROGRAMA PRINCIPAL
#--Se va letendo la entreada del keyboard y almacenandola en la memoria del display register address para mostrar en display
#--Salimos del bucle de lectura de la entrada pulsado el 0, cuenta la consola normal el numero de pulsaciones del teclado
#----------------------------------------------
					
		li	s1, disp_register_addr
		li 	s3,  '0'
		
		#imprimir string
		
		li	a0, disp_ready_addr
		li	a1, disp_register_addr
		la	a2, string
		
		jal print_string
		
		
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
