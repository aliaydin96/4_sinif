


				AREA subroutine,CODE,READONLY
				THUMB
				EXPORT portals

portals			PROC
				MOV		R2, #0x04
				MOV		R3,	#0x0D
START1			CMP 	R0, #99
				BGT 	PORTAL1
				
START2			CMP		R0, #50
				PUSH	{R0}
				BGT 	loop1
				CMP		R0, #1
				POP		{R0}
				BEQ		PORTAL2
				
				
loop1							

PORTAL1			;PUSH	{R0}	
				SUBS	R0, #47
				CMP 	R0, #99
				BGT 	PORTAL1
				;POP		{R0}
				B		START1
PORTAL2			
				



				ENDP
				END
