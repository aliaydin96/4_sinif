GPIO_PORTB_DATA 	EQU 0x400053FC

			AREA    	main, READONLY, CODE
			THUMB
			EXTERN		SignalSend;	GPIO signal send
			EXTERN		InitGPIO; GPIO initialize
			EXTERN		delay; Delay is available
			EXTERN		SysTick_Handler;CHECKINPUT ; Input Check is available
			EXTERN		Init_Timer
			EXPORT  	__main	; Make available
__main
			BL		InitGPIO; GPIO initialized
			MOV		R4, #1;
			MOV		R6, #0;
			BL		SignalSend;
			MOV		R5,#0; R2 holds the information cw or ccw
			MOV		R4, #1;
			LDR		R10, =500000			
			BL		Init_Timer
			MOV32	R10, #600000
BEGIN		
			;WFI;BL		CHECKINPUT

			B		BEGIN		
			ALIGN
			END			