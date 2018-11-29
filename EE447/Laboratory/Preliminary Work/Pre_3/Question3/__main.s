
;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	main, READONLY, CODE
			THUMB
			EXTERN		SignalSend;	GPIO signal send
			EXTERN		InitGPIO; GPIO initialize
			EXTERN		delay; Delay is available
			EXTERN		CheckInput ; Input Check is available
			EXPORT  	__main	; Make available

__main
			BL		InitGPIO; GPIO initialized
			MOV		R3, #1;
			MOV		R6, #0;
			BL		SignalSend;
Begin		BL		CheckInput;
			CMP 	R2, #0
			BEQ		Begin;
			CMP		R2, #1
			BEQ		CW
			CMP		R2, #2
			BEQ		CCW
			B		Begin
CW			AND		R3,R3,#15;
			CMP		R3,#1
			MOVEQ	R3,#8;
			LSRNE	R3,R3,#1;
			MOV		R6,R3;
			BL		SignalSend;
			B		Begin;
CCW			AND		R3,R3,#15;
			CMP		R3,#8
			MOVEQ	R3,#1;
			LSLNE	R3,R3,#1;
			MOV		R6,R3;
			BL		SignalSend;
			B		Begin;
			ALIGN
			END