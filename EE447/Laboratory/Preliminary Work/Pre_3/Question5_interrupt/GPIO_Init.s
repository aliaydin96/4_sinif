GPIO_PORTB_DATA 	EQU 0x400053FC
GPIO_PORTB_DIR 		EQU 0x40005400
GPIO_PORTB_AFSEL	EQU 0x40005420
GPIO_PORTB_DEN 		EQU 0x4000551C
GPIO_PORTB_PUR 		EQU 0x40005510
GPIO_PORTB_PDR 		EQU 0x40005514	
IOB 				EQU 0x0F
SYSCTL_RCGCGPIO 	EQU 0x400FE608
GPIO_PORTB_IS		EQU 0x40005404	
GPIO_PORTB_IBE		EQU 0x40005408	
GPIO_PORTB_IEV		EQU 0x4000540C	
GPIO_PORTB_IM		EQU 0x40005410	
GPIO_PORTB_ICR		EQU 0x4000541C		
GPIO_PORTB_RIS		EQU 0x40005414
	
	
;***************************************************************
; Program section					      
;***************************************************************
;LABEL		DIRECTIVE	VALUE		COMMENT
;LABEL DIRECTIVE VALUE COMMENT
			AREA rutins , CODE, READONLY
			THUMB
			EXPORT InitGPIO ;
InitGPIO	PROC                    
			LDR R1 , =SYSCTL_RCGCGPIO
			LDR R0 , [ R1 ]
			ORR R0 , R0 , #0x2;Port B clock enabled
			STR R0 , [ R1 ]
			NOP		;Wait for clock to stabilize
			NOP
			NOP
			LDR R1 , =GPIO_PORTB_DIR ; Config of Port B starts
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
			ORR R0 , #0xF0
			STR R0 , [ R1 ]

;			LDR	R1, =GPIO_PORTB_IS
;			LDR R2, =GPIO_PORTB_IBE
;			LDR R3, =GPIO_PORTB_IEV
;			LDR R4, =GPIO_PORTB_IM
;			LDR R5, =GPIO_PORTB_ICR
;			MOV R0, #0x00
;			STR R0, [R1]
;			STR R0, [R2]
;			STR	R0, [R3]
;			MOV	R0, #0xF0
;			STR R0, [R4]
;			STR R0, [R5]	
			LDR R1 , =GPIO_PORTB_DATA
			MOV R0, #0x0
			STR	R0, [R1]			
			BX LR; end

			ALIGN
			ENDP
			END
				
				