NVIC_ST_RELOAD 	EQU 0xE000E014
;***************************************************************
; Program section					      
;***************************************************************
;LABEL		DIRECTIVE	VALUE		COMMENT
;LABEL DIRECTIVE VALUE COMMENT
			AREA rutins , CODE, READONLY
			;THUMB
			EXTERN SignalSend;		
			EXPORT DriveMotor ;
DriveMotor	PROC                    
			MOV		R4,#2;
			CMP		R2,#0;
			BX		LR;
			CMP		R2,#1
			BEQ		CW
			CMP		R2,#2
			BEQ		CCW
			CMP		R2,#3
			BEQ		SpeedUp
			CMP		R2,#4
			BEQ		SpeedDown
CW			AND		R3,R3,#15;
			CMP		R3,#1
			MOVEQ	R3,#8;
			LSRNE	R3,R3,#1;
			MOV		R6,R3;
			PUSH	{LR}
			BL		SignalSend;
			POP		{LR}
			BX		LR; end
CCW			AND		R3,R3,#15;
			CMP		R3,#8
			MOVEQ	R3,#1;
			LSLNE	R3,R3,#1;
			MOV		R6,R3;
			PUSH	{LR}
			BL		SignalSend;
			POP		{LR}
			BX		LR; end
SpeedUp		LDR 	R1,=NVIC_ST_RELOAD
			LDR		R0,[R1]
		    UDIV 	R0,R0,R4 ;Interrupt period is decreased
			STR		R0,[R1]
			MOV		R2,R7;
			BX 		LR; end
SpeedDown	LDR 	R1,=NVIC_ST_RELOAD
			LDR		R0,[R1]
			MUL		R0,R0,R4 ;Interrupt period is increased
			STR		R0,[R1]
			MOV		R2,R7;
			BX 		LR; end

;***************************************************************
; End of the program  section
;***************************************************************
;LABEL      DIRECTIVE       VALUE                           COMMENT
			
			ENDP
			END