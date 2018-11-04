


				AREA subroutine,CODE,READONLY
				THUMB
				EXPORT portals

portals			PROC
				PUSH	{LR}
				MOV		R4, #0	
				MOV		R2, #0
				MOV		R7,	#0
				CMP 	R0, #99
				BLS		START1
				ADD		R4, #1
				
START1			
				AND		R2, R0, #1
				BNE		START2
				ADD		R4,	#2
				B		START3
				
START2			
				CMP		R0, #50
				BLS		START3
				ADD		R4, #4

START3			MOV		R2, #7
				UDIV	R7, R0, R2
				MUL		R7, R2
				SUBS	R7, R0
				BNE		MAIN
				ADD		R4, #8
				

MAIN			ANDS	R7, R4, #1
				CMP		R7, #1
				BEQ		PORTAL1
				ANDS	R7, R4, #2
				CMP		R7, #2
				BEQ		PORTAL2
				ANDS	R7, R4, #4
				CMP		R7, #4
				BEQ		PORTAL3
				ANDS	R7, R4, #8
				CMP		R7, #8
				BEQ 	PORTAL4
				B		FINISH


PORTAL1			PUSH	{R0}
				SUBS	R0, #47
				SUB		R4, #1
				PUSH	{R4}
				PUSH 	{LR}
				BL 		portals
				POP		{LR}
				POP		{R4}
				POP		{R0}
				B 		MAIN
PORTAL2 		PUSH	{R0}
				MOV 	R3, #10
				MOV 	R2, #1
loop1	 		UDIV 	R8, R0, R3
				CMP 	R0,	#0
				BEQ 	PORTAL2END
				MLS 	R9, R8, R3, R0
				MOV 	R0, R8
				CMP 	R9, #0
				BEQ 	loop1
				MUL 	R7, R9
				B 		loop1
PORTAL2END 		POP		{R0}
				SUB 	R0,R7
				SUB 	R4,#2
				PUSH	{R4}
				PUSH	{LR}
				BL 		portals
				POP		{LR}
				POP		{R4}
				POP		{R0}
				B 		MAIN
				
PORTAL3			LSR		R0, #2
				SUB		R4, #4
				PUSH	{R4}
				PUSH	{LR}
				BL 		portals
				POP		{LR}
				POP		{R4}
				POP		{R0}
				B 		MAIN

PORTAL4			
				PUSH	{R0}
				MOV 	R2,#3
				UDIV 	R3, R0, R2
				MUL 	R3, R2
				SUB 	R0, R3
				SUB 	R4, #8
				PUSH	{R4}
				PUSH	{LR}
				BL 		portals
				POP		{LR}
				POP		{R4}
				POP		{R0}
				B 		MAIN

FINISH			
				CMP 	R6,	R0
				BLS 	BACK
				MOV 	R6,	R0

BACK			
				BX		LR
				
				
				ENDP
				END
