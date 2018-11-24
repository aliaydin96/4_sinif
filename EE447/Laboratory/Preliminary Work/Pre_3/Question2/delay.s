				AREA 	subroutine , CODE, READONLY
				THUMB
				EXPORT 	DELAY
DELAY			PROC				
GoBack 			SUBS 	R0, R0, #1		;subtract 1 to R0
				BEQ 	End_Delay		;if r0 = 0, go end
				B 		GoBack			;
End_Delay 		BX 		LR				;end
				ALIGN
				ENDP
				END