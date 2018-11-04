
NUM 		EQU 0x20004000 ; NUM memory location
FIRST 		EQU 0x20000400 ;address for storing digits
NUMBER 		EQU 0x000ABC45 ;number will be converted

			AREA	main, CODE, READONLY
			THUMB
			EXTERN CONVRT
			IMPORT InChar
			EXTERN OutStr
			EXPORT __main
				
__main			
loop		BL InChar  			;determine to press any key
			CMP R5, #00 		; 
			BEQ loop			;if any key did not press, back to loop and wait for key
			LDR R0, =NUM 		;load NUM to r0
			LDR R1, =NUMBER 	;load number to r1
			LDR R5, =FIRST 		;load address to r5
			
			STR R1, [R0] 		;to store number in the address of NUM
			LDR R4, [R0] 		;to load number in NUM to r4
			BL CONVRT 			;to convert number to decimal, go branch 
			LDR R5, =FIRST
			BL OutStr 			;to write number on termite
			B loop 				;back to loop

				
			ALIGN
			END





