;***************************************************************
; Program section					      
;***************************************************************
;LABEL		DIRECTIVE	VALUE		COMMENT
;LABEL DIRECTIVE VALUE COMMENT
			AREA rutins , CODE, READONLY
			THUMB
			EXPORT delay ;
delay		PROC                    
		
GoBack		SUBS	R0,R0,#1;
			BEQ		End_Delay
			B		GoBack
End_Delay	BX LR; end

;***************************************************************
; End of the program  section
;***************************************************************
;LABEL      DIRECTIVE       VALUE                           COMMENT
			ALIGN
			ENDP
			END