GPIO_PORTB_DATA 	EQU 0x400053FC

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
				AREA sdata , DATA, READONLY
				THUMB
MSG 			DCB "PULSE WIDTH "
				DCB 0x0D
				DCB 0x04
MSG1 			DCB "PERIOD "
				DCB 0x0D
				DCB 0x04
MSG2 			DCB "DUTY CYCLE % "
				DCB 0x0D
				DCB 0x04				
;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	main, READONLY, CODE
			THUMB
			EXTERN		PULSE_INIT		; Pulse initialization
			EXTERN		READ_INIT
			EXTERN		OutStr
			EXTERN		CONVRT
			EXPORT  	__main	; Make available

__main
			BL		READ_INIT;	initialize read
			BL		PULSE_INIT; initialize pulse
START	
			MOV		R0,#0; R0 is turn counter 
			MOV 	R10, #0
			MOV 	R8, #0
			MOV		R6, #0
			PUSH	{R0}
			
loop		LDR 	R1, =TIMER1_RIS
			LDR 	R2, [R1]
			ANDS 	R2, #04 ; isolate CAERIS bit
			BEQ 	loop ; if no capture, then loop
			
			LDR 	R1, =TIMER1_ICR;
			ORR		R2, #0x04; by setting CAECINT bit to 1, CAERIS bir is cleared
			STR		R2, [R1]
			LDR		R1, =GPIO_PORTB_DATA
			LDR		R2, [R1]
			LDR 	R1, =TIMER1_TAR ; address of timer register
			LDR 	R0, [R1] ; Get timer register value 
			CMP		R6, #0
			BEQ		FIRST_NUMBER
			CMP		R8, #0
			BEQ 	SECOND_NUMBER
			CMP		R10, #0
			BEQ		THIRD_NUMBER
			
FIRST_NUMBER			
			CMP		R2, #0x10 ;IF sees positive edge, contunie
			BNE		loop  ;if not, go begin
			MOV		R6, R0	
			B		loop
SECOND_NUMBER		
			MOV		R8, R0
			B		loop
THIRD_NUMBER	
			MOV		R10, R0
			B		CONTINUE
			
			
CONTINUE		
			PUSH	{R5, R6, R7, R8}
			LDR 	R5,=MSG
			BL 		OutStr;to write string above definition
			POP 	{R5, R6, R7, R8}
			MOV		R2, #16
			UDIV	R6, R6, R2  ; r6 to microsec(us)
			UDIV	R8,	R8, R2	;r8 to us
			UDIV	R10, R10, R2 ;r10 to us
			SUB		R4, R6, R8	;to find pulse width
			PUSH	{R5, R6, R7, R8}
			LDR		R5,=FIRST;
			BL		CONVRT	
			LDR		R5,=FIRST;			
			BL	OutStr	; write pulse width
			POP 	{R5, R6, R7, R8}
			PUSH	{R5, R6, R7, R8}
			LDR 	R5,=MSG1
			BL 		OutStr ;write string
			POP 	{R5, R6, R7, R8}
			MOV		R4, #0
			SUB		R4, R6, R10 ;to find period
			PUSH	{R5, R6, R7, R8}
			LDR		R5,=FIRST;
			BL		CONVRT 
			LDR		R5,=FIRST;			
			BL		OutStr ;write period
			POP 	{R5, R6, R7, R8}			
			PUSH	{R5, R6, R7, R8}
			LDR 	R5,=MSG2
			BL 		OutStr ;write string
			POP 	{R5, R6, R7, R8}
			SUB		R4, R6, R10	;period
			MOV		R11, #100
			SUB		R6, R6, R8	;pulse width
			MUL		R6, R6, R11
			UDIV	R4,	R6, R4 ;duty cycle
			PUSH	{R5, R6, R7, R8}
			LDR		R5,=FIRST;
			BL		CONVRT 
			LDR		R5,=FIRST;			
			BL		OutStr	;write duty cycle
			POP 	{R5, R6, R7, R8}
			
			B		START
			ALIGN
			END
