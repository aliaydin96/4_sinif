

OFFSET  	EQU     	0x10
FIRST	   	EQU	    	0x20000480	
STORE		EQU			0x20000400
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
			EXTERN		OutStr	; Reference external subroutine	
			EXTERN		DELAY;
			EXTERN		CONVRT
			EXPORT  	__main	
__main
Start		LDR R1 , =SYSCTL_RCGCGPIO
			LDR R0 , [ R1 ]
			ORR R0 , R0 , #0x2;Port B clock enabled
			STR R0 , [ R1 ]
			NOP		;Wait for clock to stabilize
			NOP
			NOP
			LDR R1 , =GPIO_PORTB_DIR ; 
			LDR R0 , [ R1 ]
			BIC R0 , #0xFF 
			ORR R0 , #IOB
			STR R0 , [ R1 ]
			LDR R1 , =GPIO_PORTB_AFSEL
			LDR R0 , [ R1 ]
			BIC R0 , #0xFF
			STR R0 , [ R1 ]
			LDR R1 , =GPIO_PORTB_DEN
			LDR R0 , [ R1 ]
			ORR R0 , #0xFF
			STR R0 , [ R1 ]
			LDR R1 , =GPIO_PORTB_PUR
			LDR R0 , [ R1 ]
			ORR R0 , #0x0F
			STR R0 , [ R1 ]
			
Begin		LDR	R1,=GPIO_PORTB_DATA ;Data address in R1
			MOV	R0,#0x00	
			STR	R0,[R1]				;All outputs GND
			MOV	R2,#0;				R2 is the switch ID
LOOP		
			LDR	R1,=GPIO_PORTB_DATA; Data address in R1
			MOV32	R5,#0xE0	
			STR	R5,[R1];	All outputs GND
			LDR	R1,=GPIO_PORTB_DATA
			LDR	R2, [R1]
			AND R2, #0xF	;AND r2 with f, to determine pressed button  
			CMP R2, #0xF	
			BEQ LOOP2		;if button is not pressed, go to loop2
			MOV32 R0, #160000	
			BL  DELAY		;wait 100msec
			LDR	R1,=GPIO_PORTB_DATA	
			LDR	R3, [R1]	;
			AND R3, #0xF	;AND r3 with f, to determine pressed button 
			CMP R2, R3		;if they are equal, button is pressed
			BNE LOOP		
			ADD R5, R5, R2	
			CMP R5, #0xEE	;for k1
			MOVEQ R4, #0
			CMP R5, #0xED	;for k2 
			MOVEQ R4, #1			
			CMP R5, #0xEB	;for k3
			MOVEQ R4, #2
			CMP R5, #0xE7	;for k4
			MOVEQ R4, #3
			B	RELEASE		;go release func.
LOOP2		
			LDR	R1,=GPIO_PORTB_DATA; Data address in R1
			MOV32	R5,#0xD0	
			STR	R5,[R1];	All outputs GND
			LDR	R1,=GPIO_PORTB_DATA
			LDR	R2, [R1]
			AND R2, #0xF
			CMP R2, #0xF
			BEQ LOOP3
			MOV32 R0, #160000
			BL  DELAY
			LDR	R1,=GPIO_PORTB_DATA
			LDR	R3, [R1]
			AND R3, #0xF
			CMP R2, R3
			BNE LOOP2
			ADD R5, R5, R2
			CMP R5, #0xDE	;for k5
			MOVEQ R4, #4
			CMP R5, #0xDD	;for k6
			MOVEQ R4, #5			
			CMP R5, #0xDB	;for k7
			MOVEQ R4, #6
			CMP R5, #0xD7	;for k8
			MOVEQ R4, #7	
			B	RELEASE
LOOP3		
			LDR	R1,=GPIO_PORTB_DATA; Data address in R1
			MOV32	R5,#0xB0	
			STR	R5,[R1];	All outputs GND
			LDR	R1,=GPIO_PORTB_DATA
			LDR	R2, [R1]
			AND R2, #0xF
			CMP R2, #0xF
			BEQ LOOP4
			MOV32 R0, #160000
			BL  DELAY
			LDR	R1,=GPIO_PORTB_DATA
			LDR	R3, [R1]
			AND R3, #0xF
			CMP R2, R3
			BNE LOOP3
			ADD R5, R5, R2
			CMP R5, #0xBE	;for k9
			MOVEQ R4, #8
			CMP R5, #0xBD	;for k10
			MOVEQ R4, #9			
			CMP R5, #0xBB	;for k11
			MOVEQ R4, #10	
			CMP R5, #0xB7	;for k12
			MOVEQ R4, #11
			B	RELEASE			
			
LOOP4		
			LDR	R1,=GPIO_PORTB_DATA; Data address in R1
			MOV32	R5,#0x70	
			STR	R5,[R1];	All outputs GND
			LDR	R1,=GPIO_PORTB_DATA
			LDR	R2, [R1]
			AND R2, #0xF
			CMP R2, #0xF
			BEQ LOOP
			MOV32 R0, #160000
			BL  DELAY
			LDR	R1,=GPIO_PORTB_DATA
			LDR	R3, [R1]
			AND R3, #0xF
			CMP R2, R3
			BNE LOOP4
			ADD R5, R5, R2
			CMP R5, #0x7E	;for k13
			MOVEQ R4, #12	
			CMP R5, #0x7D	;for k14
			MOVEQ R4, #13			
			CMP R5, #0x7B	;for k15
			MOVEQ R4, #14
			CMP R5, #0x77	;for k16
			MOVEQ R4, #15
			B	RELEASE				
			
RELEASE     
			LDR	R1,=GPIO_PORTB_DATA
			LDR	R2, [R1]	;again take input 
			AND R2, #0xF	;if button is released
			CMP R2, #0xF	;go to output
			BEQ	OUTPUT		;if not go release and wait
			B   RELEASE
OUTPUT      
			
			LDR R5, =STORE	;r4 is button number
			BL  CONVRT		;convert number to ascii
			LDR R5, =STORE
			BL	OutStr		;write number to termite
			ALIGN
			END