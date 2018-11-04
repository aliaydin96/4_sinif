FIRST 	EQU 0x20000400


		AREA	main, CODE, READONLY
		THUMB
		EXTERN CONVRT
		IMPORT InChar
		EXTERN OutStr
		IMPORT UPBND
		EXPORT __main
				
__main			
start 	MOV R0, #0 			;to store n value
		MOV R1, #10 		;to take 2 digit decimal number
		BL  InChar 			;take 2nd digit of the number
		SUB R5, #0x30 		;to take string as number, eliminate offset
		ADD R0, R5 			;add number to r0
		MUL R0, R1 			;multiply with 10 since 2nd digit of number
		BL  InChar 			;take 1st digit of the number
		SUB R5, #0x30 		;to take string as number, eliminate offset
		ADD R0, R5 			;add to 2nd digit
		LDR R2, =0x00 		;lower boundary
		LDR R3, =0x01 		;upper boundary
		LSL R3, R0 			;upper boundary = 2^n, shift r3 wrt n(input)
		
findingNumber
		ADD R4, R3, R2 		;= upper + lower boundaries
		LSR R4, #0x1 		;divide sum with 2 to obtain middle value
		LDR R5, =FIRST 		;load address to r5
		BL  CONVRT 			;convert number to decimal
		LDR R5, =FIRST 		;load address to r5
		BL  OutStr 			;write number to port
		BL  InChar 			;U(up) and D(down) or C(correct)
		CMP R5, #0x43 		;if correct, start beginning again
		BEQ start 			;go to start
		BL  UPBND 			;if not correct, determine new boundaries
		B   findingNumber	;go to find number
		
		ALIGN
		END





