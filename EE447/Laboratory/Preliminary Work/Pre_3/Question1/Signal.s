GPIO_PORTB_DATA 	EQU 0x400053FC
;***************************************************************
; Program section					      
;***************************************************************
;LABEL		DIRECTIVE	VALUE		COMMENT
;LABEL DIRECTIVE VALUE COMMENT
			AREA rutins , CODE, READONLY
			THUMB
			EXPORT SysTick_Handler ;
SysTick_Handler PROC 
			LDR		R1,=GPIO_PORTB_DATA; Data address in R1
			MOV		R0, R4
			STR		R0,[R1];	Corresponding Outputs set high
			LSL		R4, R4, #1					
			BX LR; end

;***************************************************************
; End of the program  section
;***************************************************************
;LABEL      DIRECTIVE       VALUE                           COMMENT
			ALIGN
			ENDP
			END
				