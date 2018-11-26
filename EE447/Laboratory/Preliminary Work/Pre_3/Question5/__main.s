			AREA    	main, READONLY, CODE
			THUMB
			EXTERN		SignalSend;	GPIO signal send
			EXTERN		InitGPIO; GPIO initialize
			EXTERN		delay; Delay is available
			EXTERN		CHECKINPUT ; Input Check is available
			EXPORT  	__main	; Make available
__main
			BL		InitGPIO; GPIO initialized
			MOV		R3, #1;
			MOV		R6, #0;
			BL		SignalSend;
BEGIN		BL		CHECKINPUT
			B		BEGIN		
			ALIGN
			END			