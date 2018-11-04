
FIRST 			EQU 	0x20000400
				AREA main,CODE,READONLY
				THUMB
				EXTERN InChar
				EXTERN OutStr
				EXTERN CONVRT
				EXTERN portals

				EXPORT __main
__main
start			MOV 	R0,#0 			;input number 
				MOV 	R1,#10 			;base value
				
findingNumber 	BL 		InChar 			;take digit of input number
				CMP 	R5,#0x2D 		;compare input with '-'
				BEQ 	PORTAL 			;if equal, go to portal
				MUL 	R0,R1 			;if not, multiply with current number with base value
				SUB 	R5,#0x30 		;eliminate ascii offset
				ADD 	R0,R5 			;add to number to storage register
				B 		findingNumber 	;take next digit
				
PORTAL 			MOV 	R8,R0 			;keep number a register with no change
				BL 		portals			;go to portals subroutine
				MOV 	R4,R0 			;load number to r4
				LDR 	R5,=FIRST
				BL 		CONVRT 			;convert to decimal
				LDR 	R5,=FIRST
				BL 		OutStr 			;show the decimal number
				B 		start 			;go to start
				END