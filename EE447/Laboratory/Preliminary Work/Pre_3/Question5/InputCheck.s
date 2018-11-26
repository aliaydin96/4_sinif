GPIO_PORTB_DATA 	EQU 0x400053FC
GPIO_PORTB_ICR		EQU 0x4000541C
GPIO_PORTB_RIS		EQU 0x40005414	
			AREA rutins , CODE, READONLY
			THUMB
			EXPORT  CHECKINPUT;GPIOPortB_Handler ;
			EXTERN	SignalSend;	GPIO signal send
			EXTERN  delay;
CHECKINPUT  PROC    
			LDR		R1,=GPIO_PORTB_DATA; Data address in R1
			MOV		R2,#0; R2 holds the information cw or ccw
			MOV		R3, #1;
			MOV32	R7, #1000000
			MOV		R4, #0
Check		MOV		R2, R4
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
			CMP		R2, #1
			BEQ		CW
			CMP		R2, #2
			BEQ		CCW
			CMP		R2, #3
			BEQ		SPEEDUP
			CMP		R2, #4
			BEQ		SPEEDDOWN
			B		Check
Delay100	MOV32	R0,#160000;If any input is detected
			PUSH{LR}
			BL		delay
			POP{LR}
			LDR 	R0,[R1];	Check Again
			LSR		R0,#4;
			LSRS	R0,#1;
			MOVCC	R2,#1; 1 is the cw direction PB4 pressed
			BCC		Released ; If input is detected again wait for relase
			LSRS	R0,#1;
			MOVCC	R2,#2; 2 is the ccw direction PB5 pressed
			BCC		Released
			LSRS	R0,#1;
			MOVCC	R2,#3; 3 is the speed-up direction PB6 pressed
			BCC		Released ; If input is detected again wait for relase
			LSRS	R0,#1;
			MOVCC	R2,#4; 4 is the speed-down direction PB7 pressed
			BCC		Released
			BX LR; if no signal

						
Released	LDR 	R0,[R1];	It checks for if the switch is open again
			LSR		R0,#4;
			LSRS	R0,#1;
			BCC		Released;	If it is not open
			LSRS	R0,#1;
			BCC		Released;
			LSRS	R0,#1;
			BCC		Released;	If it is not open
			LSRS	R0,#1;
			BCC		Released;
			CMP		R2, #1
			BEQ		CW
			CMP		R2, #2
			BEQ		CCW
			CMP		R2, #3
			BEQ		SPEEDUP
			CMP		R2, #4
			BEQ		SPEEDDOWN	
		
CW			AND		R3,R3,#15;
			CMP		R3,#1
			MOVEQ	R3,#8;
			LSRNE	R3,R3,#1;
			MOV		R6,R3;
			BL		SignalSend
			MOV		R0, #0
			ADD 	R0, R7
			PUSH	{LR}
			BL		delay
			POP		{LR}
			MOV		R4, R2
			B		Check;	
			
CCW			AND		R3,R3,#15;
			CMP		R3,#8
			MOVEQ	R3,#1;
			LSLNE	R3,R3,#1;
			MOV		R6,R3;
			BL		SignalSend;
			MOV		R0, #0
			ADD 	R0, R7
			PUSH	{LR}
			BL		delay
			POP		{LR}
			MOV		R4, R2
			B		Check;			
SPEEDUP		
			MOV32	R7, #160000
			B		Check
SPEEDDOWN 	
			MOV32	R7, #1600000			
			B		Check
			BX LR; end

			ALIGN
			ENDP
			END