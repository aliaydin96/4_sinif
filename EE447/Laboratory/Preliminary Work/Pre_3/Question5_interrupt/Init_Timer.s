SYSCTRL		EQU	0xE000E010
			AREA rutins , CODE, READONLY
			THUMB
			EXPORT Init_Timer ;
				
Init_Timer	PROC
			LDR		R0, =SYSCTRL
			MOV 	R1, #0
			STR		R1, [R0]
			STR		R10, [R0, #4]
			STR		R10, [R0, #8]
			MOV		R1, #3
			STR		R1, [R0]
			BX		LR

			ALIGN
			ENDP
			END

