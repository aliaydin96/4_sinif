GPIO_PORTB_DATA 	EQU 0x400053FC


;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	main, READONLY, CODE
			THUMB
			EXTERN		OutStr	; Reference external subroutine	
			EXTERN		InChar; Serial input Added
			EXTERN		Signal;	GPIO signal send
			EXTERN		InitGPIO; GPIO initialize
			EXTERN		DELAY
			EXPORT  	__main	; Make available

__main
			BL		InitGPIO; GPIO initialized
			MOV 	R4, #0x8; Set for Full Step config
			MOV 	R5, #0x8; Set for Full Step config
Begin		
			LDR		R1,=GPIO_PORTB_DATA
			LDR		R2, [R1]
			AND 	R2, #0xF	;AND r2 with f, to determine pressed button  
			CMP 	R2, #0xF	
			BEQ 	Begin		;if button is not pressed, go to loop2
			MOV32 	R0, #160000	
			BL  	DELAY		;wait 100msec
			LDR		R1,=GPIO_PORTB_DATA	
			LDR		R3, [R1]	;
			AND 	R3, #0xF	;AND r3 with f, to determine pressed button 
			CMP 	R2, R3		;if they are equal, button is pressed
			BNE		Begin
			CMP 	R2, #0xE
			BEQ		FORWARD
			CMP 	R2, #0xD
			BEQ		REVERSE
			B		Begin
			
FORWARD			
			LSL		R4, R4, #1
			MOV		R0, R4
			BL		Signal;
			MOV32	R0, #1600000
			BL 		DELAY
			CMP		R4, #0x80
			BNE		Begin
			MOV		R4, #0x08
			B		Begin

REVERSE
			MOV 	R0, R5; Set for Full Step config
			BL		Signal;
			LSR		R5, R5, #1
			MOV32	R0, #1600000
			BL 		DELAY
			CMP		R5, #0x08
			BNE		Begin
			MOV		R5, #0x80
			B		Begin
;***************************************************************
; End of the program  section
;***************************************************************
;LABEL      DIRECTIVE       VALUE                           COMMENT
			ALIGN
			END