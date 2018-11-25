GPIO_PORTB_DATA 	EQU 0x400053FC

			AREA rutins , CODE, READONLY
			THUMB
			EXPORT CheckInput ;
			EXTERN delay;
CheckInput	PROC    
			LDR		R1,=GPIO_PORTB_DATA; Data address in R1
			MOV		R2,#0; R2 holds the information cw or ccw
Check		LDR 	R0,[R1];Checks for any input
			LSR		R0,#4;
			LSRS	R0,#1;
			BCC		Delay100
			LSRS	R0,#1;
			BCC		Delay100
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
			BX LR; if no signal

						
Released	LDR 	R0,[R1];	It checks for if the switch is open again
			LSR		R0,#4;
			LSRS	R0,#1;
			BCC		Released;	If it is not open
			LSRS	R0,#1;
			BCC		Released;
			BX LR; end

			ALIGN
			ENDP
			END