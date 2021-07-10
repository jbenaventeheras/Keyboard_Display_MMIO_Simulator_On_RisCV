.include "servicios_mmio.asm"

.eqv op_suma 0x0000002b #+
.eqv op_mult 0x00000078 # x
.eqv op_div 0x0000002f # /
.eqv segundo_digito 0x00000035 #5
.eqv tercer_digito 0x00000037 #4


.data



string:		.asciz "-INTRODUC1E PRIMER DIGITO \n"
string2:	.asciz "INTRODUCE SEGUNDO DIGITO \n"
string3:	.asciz "INTRODUCE OPRENDO * x / \n"

.text


	
#----------------------------------------------
#-- PROGRAMA PRINCIPAL
#----------------------------------------------

		#imprimir string
		
		li	a0, disp_ready_addr
		li	a1, disp_register_addr
		li 	a2, reciber_control_regis
		la	a3, string
		jal print_string
		
		#leer primer digito
		li	a0, disp_ready_addr
		li	a1, disp_register_addr
		li 	a3, keystroke_text_area
		jal 	read_int
				
		mv s0, a0
		
		#imprimir string
		
		li	a0, disp_ready_addr
		li	a1, disp_register_addr
		li 	a2, reciber_control_regis
		la	a3, string2
		jal print_string
		
		#leer segundo digito
		li	a0, disp_ready_addr
		li	a1, disp_register_addr
		li 	a3, keystroke_text_area
		jal 	read_int
		
		mv s1,a0
		
		#imprimir string
		
		li	a0, disp_ready_addr
		li	a1, disp_register_addr
		li 	a2, reciber_control_regis
		la	a3, string3
		jal print_string
		
		
		
		#leer operador
		li	a0, disp_ready_addr
		li	a1, disp_register_addr
		li 	a3, keystroke_text_area
		jal	read_keyboard
		
		mv s2, a0
		
		li	t0, op_suma 
		li	t1, op_mult
		li	t2, op_div
		
		beq	t0, s2, suma
		beq     t1, s2, multi
		beq	t2, s2, divi
		
suma:		
		mv a0, s0
		mv a1, s1
		

		jal sumar
				
		
		b fin
		
multi:		
		mv a0, s0
		mv a1, s1
		

		jal multiplicar
				
		
		b fin	

divi:		
		mv a0, s0
		mv a1, s1
		

		jal dividir
				
		
		b fin
	
fin:		

		li  a7, 1 
		ecall
		# Terminate
		li	a7, 10
		ecall
