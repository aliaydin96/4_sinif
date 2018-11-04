


		AREA	routines, CODE, READONLY
		THUMB	
		EXPORT UPBND

UPBND	PROC
		CMP 	R5,#0x55 		;compare input U(up)
		ADDEQ 	R2,R4,#1 		;if U(up), add middle to 1 for new lower bound
		CMP 	R5,#0x44 		;compare input D(down)
		SUBEQ 	R3,R4,#1 		;if D(down), subtract middle to 1 for new upper bound
		BX 		LR 				;go to main

		ENDP
		ALIGN
		END