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
			EXTERN		delay;
			EXPORT  	__main	; Make available

__main
turnback	LDR R1,=FIRST
			MOV	R6,#5
			MOV32 R0,#25400000; Clock number for wait
			BL	delay
			ADD R6,R6,#0x30; ASCII code modified
			STR R6,[R1];	R6 is stored to where R0 points
			MOV R5,R1;		OutStr modification
			ADD	R1,R1,#1;
			MOV R2,#0x04;
			STR	R2,[R1];	End setup for OutStr
			BL	OutStr
			B turnback
;***************************************************************
; End of the program  section
;***************************************************************
;LABEL      DIRECTIVE       VALUE                           COMMENT
			ALIGN
			END