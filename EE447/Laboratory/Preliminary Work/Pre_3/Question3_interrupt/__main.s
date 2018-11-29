GPIO_PORTB_DATA 	EQU 0x400053FC
;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	main, READONLY, CODE
			THUMB
			EXTERN		OutStr	; Reference external subroutine	
			EXTERN		InChar; Serial input Added
			EXTERN		SignalSend;	GPIO signal send
			EXTERN		InitGPIO; GPIO initialize
			EXTERN		delay; Delay is available
			EXTERN		SysTick_Handler ; Input Check is available
			EXTERN		Init_Timer
			EXTERN		inputcheck
			EXPORT  	__main	; Make available

__main
			BL		InitGPIO; GPIO initialized
			MOV		R4, #1;
			MOV		R6, #0;
			BL		SignalSend;
			MOV		R5,#0; R2 holds the information cw or ccw
			MOV		R4, #1;
			BL		Init_Timer
		
LOOP		B		LOOP
			ALIGN
			END