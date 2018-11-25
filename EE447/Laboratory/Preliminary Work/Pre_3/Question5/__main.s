			AREA    	main, READONLY, CODE
			THUMB
			EXTERN		OutStr	; Reference external subroutine	
			EXTERN		InChar; Serial input Added
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
			
;			CMP		R2, #0
;			BEQ		BEGIN
;			CMP		R2, #1
;			BEQ		CW
;			B		BEGIN
;			
;			
;CW			AND		R3,R3,#15;
;			CMP		R3,#1
;			MOVEQ	R3,#8;
;			LSRNE	R3,R3,#1;
;			MOV		R6,R3;
;			B		CW;
			
			
			
			
			
			
			ALIGN
			END			