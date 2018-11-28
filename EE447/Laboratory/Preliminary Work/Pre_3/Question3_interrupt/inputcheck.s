GPIO_PORTB_DATA 	EQU 0x400053FC
			AREA rutins , CODE, READONLY
			THUMB
			EXPORT SysTick_Handler 
			EXTERN	SignalSend;
			EXTERN delay;
SysTick_Handler	PROC  
			MOV		R2, #0
			ADD		R2, R4
			CMP 	R2, #0
			BEQ		DONE;
			CMP		R2, #1
			BEQ		CW
			CMP		R2, #2
			BEQ		CCW

DONE		BX		LR
CW			AND		R3,R3,#15;
			CMP		R3,#1
			MOVEQ	R3,#8;
			LSRNE	R3,R3,#1;
			MOV		R6,R3;
			PUSH{LR}
			BL		SignalSend;
			POP {LR}
;			MOV32	R0,#160000;If any input is detected
;			PUSH{LR}
;			BL		delay
;			POP{LR}
			BX		LR;
CCW			AND		R3,R3,#15;
			CMP		R3,#8
			MOVEQ	R3,#1;
			LSLNE	R3,R3,#1;
			MOV		R6,R3;
			PUSH{LR}
			BL		SignalSend;
			POP {LR}
			BX		LR;			
			
			
			
			
			
			ALIGN
			ENDP
			END