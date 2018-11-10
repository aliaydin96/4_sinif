


OFFSET  			EQU 0x10
FIRST	   			EQU	0x20000480	
STORE				EQU	0x20000410
GPIO_PORTB_DATA 	EQU 0x400053FC
GPIO_PORTB_DIR 		EQU 0x40005400
GPIO_PORTB_AFSEL	EQU 0x40005420
GPIO_PORTB_DEN 		EQU 0x4000551C
GPIO_PORTB_PUR 		EQU 0x40005510
GPIO_PORTB_PDR 		EQU 0x40005514	
IOB 				EQU 0xF0
SYSCTL_RCGCGPIO 	EQU 0x400FE608



			AREA    	main, READONLY, CODE
			THUMB					
			EXTERN		DELAY;
			EXPORT  	__main			

__main
Start		LDR 	R1,	=SYSCTL_RCGCGPIO
			LDR 	R0, [R1]
			ORR 	R0, R0, #0x2			;Port B clock is enabled R0 = 00000010
			STR 	R0, [R1]				
			NOP								;Wait for clock to stabilize
			NOP
			NOP
			
			LDR 	R1, =GPIO_PORTB_DIR 	;direction of port B pins	
			LDR 	R0, [R1]				
			BIC 	R0, #0xFF 				
			ORR 	R0, #IOB				;r0 = 11110000 ;B7-B4 is output ;B3-B0 is input 
			STR 	R0, [R1]
			LDR 	R1, =GPIO_PORTB_AFSEL	;for afsel disable
			LDR 	R0, [R1]
			BIC 	R0, #0xFF
			STR 	R0, [R1]
			LDR 	R1, =GPIO_PORTB_DEN		;all pins are digital
			LDR 	R0, [R1]
			ORR 	R0, #0xFF
			STR 	R0, [R1]
			LDR 	R1, =GPIO_PORTB_PUR		;pull up resistor settle
			LDR 	R0, [R1]
			ORR 	R0, #0x00				;for input pin, pull up resistor is enabled
			STR 	R0, [R1]
			
Begin		LDR		R1,=GPIO_PORTB_DATA		;Data address in R1
			MOV		R0,#0xFF
			STR		R0,[R1]					;All outputs OFF
			
InputCheck	
			LDR		R1,=GPIO_PORTB_DATA
			LDR		R0, [R1]
			AND		R2, R0, #0x0F
			CMP		R2,#0x0F
			BEQ		InputCheck
			MOV32 	R0,#160000				;wait 100msec delay
			BL		DELAY					;prevent from bouncing
			LDR		R1,=GPIO_PORTB_DATA
			LDR		R0, [R1]
			AND		R4, R0, #0x0F
			CMP		R2, R4 					; IF they are equal set the output
			BNE		InputCheck
											; If an input is read
			LDR		R1,=GPIO_PORTB_DATA		; Data address in R1
			LSL		R4, #4
			STR		R4,[R1]					;Corresponding Outputs set high
			MOV32	R0,#16000000 			;5Sec
			BL		DELAY
			B 		Begin
			
			ALIGN
			END