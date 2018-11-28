GPIO_PORTB_DATA 	EQU 0x400053FC

			AREA rutins , CODE, READONLY
			THUMB
			EXPORT SignalSend ;
SignalSend	PROC                    
			LDR		R1,=GPIO_PORTB_DATA; Data address in R1
			STR		R6,[R1];	Corresponding Outputs set high
			BX LR; end

			ALIGN
			ENDP
			END