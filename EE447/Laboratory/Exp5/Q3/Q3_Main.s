;*************************************************************** 
; Program_Directives.s  
; Copies the table from one location
; to another memory location.           
; Directives and Addressing modes are   
; explained with this program.   
;***************************************************************	
;*************************************************************** 
; EQU Directives
; These directives do not allocate memory
;***************************************************************
;LABEL		DIRECTIVE	VALUE		COMMENT
OFFSET  	EQU     	0x10
FIRST	   	EQU	    	0x20000480	
STORE		EQU			0x20000410
;***************************************************************
; Directives - This Data Section is part of the code
; It is in the read only section  so values cannot be changed.
;***************************************************************
;LABEL		DIRECTIVE	VALUE		COMMENT
            AREA        sdata, DATA, READONLY
            THUMB
CTR1    	DCB     	0x10
MSG     	DCB     	"Copying table..."
			DCB			0x0D
			DCB			0x04
;***************************************************************
; Program section					      
;***************************************************************
;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	main, READONLY, CODE
			THUMB
			EXTERN		OutStr	; Reference external subroutine	
			EXTERN		InChar; Serial input Added
			EXTERN		SignalSend;	GPIO signal send
			EXTERN		InitGPIO; GPIO initialize
			EXTERN		delay; Delay is available
			EXTERN		CheckInput ; Input Check is available
			EXPORT  	__main	; Make available

__main
			BL		InitGPIO; GPIO initialized
			MOV		R3,#0x00000001;
			MOV		R6,#0;
			BL		SignalSend;
Begin		BL		CheckInput;
			CMP 	R2,#0
			BEQ		Begin;
			CMP		R2,#1
			BEQ		CW
			CMP		R2,#2
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
;***************************************************************
; End of the program  section
;***************************************************************
;LABEL      DIRECTIVE       VALUE                           COMMENT
			ALIGN
			END