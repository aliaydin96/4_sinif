


				AREA subroutine,CODE,READONLY
				THUMB
				EXPORT portals

portals			PROC
				;PUSH	{LR}
				CMP		R0, #0			;compare r0 to 0
				BEQ 	FINISH			;if it is zero, go to finish
				MOV		R4, #0			;mode register
				MOV		R2, #0
				MOV		R7,	#0
				CMP 	R0, #99			;compare r0 to 99
				BLS		START1			;if less than 99, go to start1
				ADD		R4, #1			;if not, add mode register 1
				
START1			
				AND		R2, R0, #1		;and r0 and 1, to find out whether number is odd or not
				CMP		R2, #1
				BEQ		START2			;if not odd number, go to start2
				ADD		R4,	#4			;if odd, add 2 to mode register
				B		START3			;and go to start3
				
START2			
				CMP		R0, #50			;compare with 50
				BLS		START3			;if less than 50, go to start3
				ADD		R4, #2			;if not, add 4 to mode register

START3			MOV		R2, #7			;r2 = 7
				UDIV	R7, R0, R2		;r7 = r0/7
				MUL		R7, R2			;r7 = r7*7
				SUBS	R7, R0			;r7 = r7 - r0 ==>result 0, then, number is multiple of 7
				BNE		MAIN			;if not, go main
				ADD		R4, #8			;if it is, add 8 to mode register
				

MAIN			
				ANDS	R7, R4, #8		;
				CMP		R7, #8			;if mode register has 8
				BEQ 	PORTAL4			;go to portal4
				ANDS	R7, R4, #1		
				CMP		R7, #1			;if mode register has 1
				BEQ		PORTAL1			;go to portal1
				ANDS	R7, R4, #2
				CMP		R7, #2			;if mode register has 2
				BEQ		PORTAL2			;go to portal2
				ANDS	R7, R4, #4
				CMP		R7, #4			;if mode register has 4
				BEQ		PORTAL3			;go to portal3
				B		FINISH


PORTAL1			PUSH	{R0}
				SUBS	R0, #47			;r0 = r0 - 47
				SUB		R4, #1			;r4 = r4 - 1
				PUSH	{R4}
				PUSH 	{LR}
				B 		portals			;go to portals
				POP		{LR}
				POP		{R4}
				POP		{R0}
				B 		MAIN
				
PORTAL2 		PUSH	{R0}
				MOV 	R3, #10			;r3 = 10
				MOV 	R2, #1			;r2 = 1
				MOV		R7, #1
loop1	 		UDIV 	R8, R0, R3		;r8 = r0 / r3
				CMP 	R0,	#0			;compare with 0
				BEQ 	PORTAL2END		;if 0, go to portal2end
				MLS 	R9, R8, R3, R0	;r9 = r0 - r8 * r3
				MOV 	R0, R8			;r0 = r8
				CMP 	R9, #0			
				BEQ 	loop1			;if r9 = 0, go to loop1
				MUL 	R7, R9			;if not, r7 = r7 * r9
				B 		loop1			;go to loop1
PORTAL2END 		POP		{R0}
				SUB 	R0,R7			;r0 = r0 - r7
				SUB 	R4,#2			;r4 = r4 - 2
				PUSH	{R4}
				PUSH	{LR}
				B 		portals
				POP		{LR}
				POP		{R4}
				POP		{R0}
				B 		MAIN
				
PORTAL3			PUSH	{R0}
				LSR		R0, #1			;r0 = r0 / 2
				SUB		R4, #4			;r4 = r4 - 4
				PUSH	{R4}
				PUSH	{LR}
				B 		portals
				POP		{LR}
				POP		{R4}
				POP		{R0}
				B 		MAIN

PORTAL4			
				PUSH	{R0}
				MOV 	R2,#3			;r2 = 3
				UDIV 	R3, R0, R2		;r3 = r0 / 3
				MUL 	R3, R2			;r3 = r3 * 3
				SUB 	R0, R3			;r0 = r0 - r3
				SUB 	R4, #8			;r4 = r4 - 8
				PUSH	{R4}
				PUSH	{LR}
				B 		portals
				POP		{LR}
				POP		{R4}
				POP		{R0}
				B 		MAIN

FINISH			
				CMP 	R6,	R0			;compare input number and result number
				BLS 	BACK			;if r6 < r0, go to back
				MOV 	R6,	R0			;r6 = r0

BACK			;POP		{LR}
				BX		LR
				
				
				ENDP
				END
