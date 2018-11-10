


					AREA 	subroutine , CODE, READONLY
					THUMB
					EXPORT 	DELAY
DELAY			PROC				
GoBack 			SUBS 	R0, R0, #1
				BEQ 	End_Delay
				B 		GoBack
End_Delay 		BX 		LR				;end

					ALIGN
					ENDP
					END