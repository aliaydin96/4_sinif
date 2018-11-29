GPIO_PORTB_DATA 	EQU 0x400053FC
			AREA rutins , CODE, READONLY
			THUMB
			EXPORT SysTick_Handler 
			EXTERN	SignalSend;
			EXTERN delay;
			EXTERN inputcheck
SysTick_Handler	PROC  
			PUSH 	{LR}
			LDR		R1,=GPIO_PORTB_DATA		
Check		
			LDR 	R0,[R1];Checks for any input
			LSR		R0,#4;
			LSRS	R0,#1;
			BCC		Delay100
			LSRS	R0,#1;
			BCC		Delay100
			LSRS	R0,#1;
			BCC		Delay100
			LSRS	R0,#1;
			BCC		Delay100
			B		Check
Delay100	MOV32	R0,#160000;If any input is detected
			BL		delay
			LDR 	R0,[R1];	Check Again
			LSR		R0,#4;
			LSRS	R0,#1;
			MOVCC	R5,#1; 1 is the cw direction PB4 pressed
			BCC		Released ; If input is detected again wait for relase
			LSRS	R0,#1;
			MOVCC	R5,#2; 2 is the ccw direction PB5 pressed
			BCC		Released
			B		Check		; if no signal

						
Released	LDR 	R0,[R1];	It checks for if the switch is open again
			LSR		R0,#4;
			LSRS	R0,#1;
			BCC		Released;	If it is not open
			LSRS	R0,#1;
			BCC		Released;
			CMP		R5, #1
			BEQ		CW
			CMP		R5, #2
			BEQ		CCW

DONE		POP		{LR}
			BX		LR
			
CW			AND		R4,R4,#15;
			CMP		R4,#1
			MOVEQ	R4,#8;
			LSRNE	R4,R4,#1;
			MOV		R6,R4;
			BL		SignalSend
			B		DONE;	
CCW			AND		R4,R4,#15;
			CMP		R4,#8
			MOVEQ	R4,#1;
			LSLNE	R4,R4,#1;
			MOV		R6,R4;
			BL		SignalSend;
			B		DONE;			
			ALIGN
			ENDP
			END