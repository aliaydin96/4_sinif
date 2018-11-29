GPIO_PORTB_DATA 	EQU 0x400053FC
GPIO_PORTB_ICR		EQU 0x4000541C
GPIO_PORTB_RIS		EQU 0x40005414	
SYSCTRL				EQU	0xE000E010
			AREA rutins , CODE, READONLY
			THUMB
			EXPORT  SysTick_Handler;GPIOPortB_Handler ;
			EXTERN	SignalSend;	GPIO signal send
			EXTERN  delay;
			EXTERN		Init_Timer
SysTick_Handler  PROC 
			PUSH	{LR}	
			LDR		R1,=GPIO_PORTB_DATA
			MOV32	R7, #1000000
			
Check		MOV		R5, #0
			ADD		R5, R9
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
			CMP		R5, #1
			BEQ		CW
			CMP		R5, #2
			BEQ		CCW
			B		Check
Delay100	MOV32	R0,#160000;If any input is detected
			PUSH{LR}
			BL		delay
			POP{LR}
			LDR 	R0,[R1];	Check Again
			LSR		R0,#4;
			LSRS	R0,#1;
			MOVCC	R5,#1; 1 is the cw direction PB4 pressed
			BCC		Released ; If input is detected again wait for relase
			LSRS	R0,#1;
			MOVCC	R5,#2; 2 is the ccw direction PB5 pressed
			BCC		Released
			LSRS	R0,#1;
			MOVCC	R5,#3; 3 is the speed-up direction PB6 pressed
			BCC		Released ; If input is detected again wait for relase
			LSRS	R0,#1;
			MOVCC	R5,#4; 4 is the speed-down direction PB7 pressed
			BCC		Released
			B		Check		; if no signal

						
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

			CMP		R5, #1
			BEQ		CW
			CMP		R5, #2
			BEQ		CCW
			CMP		R5, #3
			BEQ		SPEEDUP
			CMP		R5, #4
			BEQ		SPEEDDOWN	
		
CW			AND		R4,R4,#15;
			CMP		R4,#1
			MOVEQ	R4,#8;
			LSRNE	R4,R4,#1;
			MOV		R6,R4;
			BL		SignalSend
			MOV		R9, R5
			B		DONE;	
			
CCW			AND		R4,R4,#15;
			CMP		R4,#8
			MOVEQ	R4,#1;
			LSLNE	R4,R4,#1;
			MOV		R6,R4;
			BL		SignalSend;
			MOV		R9, R5
			B		DONE;			
SPEEDUP		
			LSRS	R10, R10, #1
			LDR R0,=SYSCTRL
			STR R10,[R0,#4]			;store into sys_reload
			STR R10,[R0,#8]
			MOV		R0, #10000
			UDIV	R10, R0
			CMP		R10, #32
			MOVCC	R10, #32
			MUL		R10, R0
			B		DONE
SPEEDDOWN 	
			LSLS	R10, R10, #1		
			LDR R0,=SYSCTRL
			STR R10,[R0,#4]			;store into sys_reload
			STR R10,[R0,#8]	
			MOV32	R0, #100000
			UDIV	R10, R0
			CMP		R10, #16
			MOVCS	R10, #16
			MUL		R10, R0
			B		DONE
		
DONE		POP	{LR}
			BX	LR
			ALIGN
			ENDP
			END