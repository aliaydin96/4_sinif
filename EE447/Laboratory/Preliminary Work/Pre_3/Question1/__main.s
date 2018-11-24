GPIO_PORTB_DATA 	EQU 0x400053FC


;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	main, READONLY, CODE
			THUMB
			EXTERN		OutStr	; Reference external subroutine	
			EXTERN		InChar; Serial input Added
			EXTERN		SysTick_Handler;	GPIO signal send
			EXTERN		InitGPIO; GPIO initialize
			IMPORT		Init_Timer
			EXPORT  	__main	; Make available

__main
			BL		InitGPIO; GPIO initialized
			BL		Init_Timer
			MOV 	R4, #0x80

Begin		AND 	R1, R4, #0x108
			CMP		R1, #0x8
			BEQ		REVERSE
			CMP		R1, #0X100
			BNE		Begin
			MOV		R4, #0x10
			B		Begin
REVERSE		MOV		R4, #0x80
			B		Begin
			ALIGN
			END