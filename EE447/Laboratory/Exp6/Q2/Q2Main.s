; 16/32 Timer Registers
TIMER1_CFG 		EQU 0x40031000 ; Configuration Register
TIMER1_TAMR 	EQU 0x40031004 ; Mode Register
TIMER1_CTL 		EQU 0x4003100C ; Control Register
TIMER1_RIS 		EQU 0x4003101C ; Raw interrupt Status
TIMER1_ICR 		EQU 0x40031024 ; Interrupt Clear Register
TIMER1_TAILR 	EQU 0x40031028 ; Interval Load Register
TIMER1_TAMATCHR EQU 0x40031030 ; Match Register
TIMER1_TAPR 	EQU 0x40031038 ; Prescaling Divider
TIMER1_TAR 		EQU 0x40031048 ; Counter Register
TIMER1_IMR		EQU	0x40031018 ; Defining Interrupt
TIMER1_TAV		EQU 0x40031050 ; To set the timer initial value
	
FIRST	   		EQU	0x20000480
FREQ			EQU	0x00F42400 ; Freq 16M
	
;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	main, READONLY, CODE
			THUMB
			EXTERN		PULSE_INIT		; Pulse initialization
			EXTERN		READ_INIT
			EXTERN		OutStr
			EXPORT  	__main	; Make available

__main
			BL	READ_INIT;	initialize read
			BL	PULSE_INIT; initialize pulse
			MOV	R0,#0; R0 is turn counter
			PUSH{R0}
			
loop		LDR R1, =TIMER1_RIS
			LDR R2, [R1]
			ANDS R2,#04 ; isolate CAERIS bit
			BEQ loop ; if no capture, then loop
			
			LDR R1, =TIMER1_ICR;
			LDR R2, [R1];
			ORR	R2, #0x04; by setting CAECINT bit to 1, CAERIS bir is cleared
			
			LDR R1, =TIMER1_TAR ; address of timer register
			LDR R0, [R1] ; Get timer register value 
			CMP	R3,#0
			MOVEQ	R4,R0; R4 0width	>-_-<
			ADDEQ	R3,R3,#1; counter increased
			LDREQ	R1,	=TIMER1_TAV
			MOVEQ	R0,#0;
			STREQ	R0,	[R1];
			BEQ 	loop;
			; R3->1
			MOV	R5,R0; R5 Pwidth	>_-_<
			MOV	R3,#0; counter is set 0
			
			LDR	R1, =FIRST;
			ADD	R0,R5,R4; R0 is period in number
			MOV	R2,#625; a thick is 625*10^-10 sec
			MUL	R0,R0,R2; R0 is period in terms of 10^-10 sec
			STR	R0,[R1]; Period is written to memory
			ADD	R1,R1,#2; NEXT ADDRESS
			
			MUL	R0,R5,R2; R0 is pulse width in terms of 10^-10 sec
			STR	R0,[R1]; 
			ADD	R1,R1,#2; NEXT ADDRESS
			
			LDR	R2, =FREQ; R2 is 16M
			ADD	R0,R5,R4; R0 is period in number
			UDIV R0,R2,R0; R0 is frequency in Hz
			STR	R0,[R1];
			ADD	R1,R1,#2; NEXT ADDRESS
			
			MOV	R2,#100;
			ADD	R0,R5,R4; R0 is period in number
			MUL	R5,R5,R2; R5 = 100*Pwidth
			UDIV R0,R5,R0; D.C. cannot be calculated if <%1
			STR	R0,[R1];
			ADD	R1,R1,#2; NEXT ADDRESS
			
			MOV	R2,#0x04;
			STR	R2,[R1]; 
			; all quantities in hex format
			LDR	R5,=FIRST;
			LDR	R1,	=TIMER1_TAV
			MOV	R0,#0;
			STR	R0,	[R1];
			;PUSH{LR}
			BL	OutStr
			;POP{LR}
			B	loop
			ALIGN
			END
