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
GPIO_PORTB_DATA 	EQU 0x400053FC
GPIO_PORTB_DIR 		EQU 0x40005400
GPIO_PORTB_AFSEL	EQU 0x40005420
GPIO_PORTB_DEN 		EQU 0x4000551C
GPIO_PORTB_PUR 		EQU 0x40005510
GPIO_PORTB_PDR 		EQU 0x40005514	
IOB 				EQU 0x0F
SYSCTL_RCGCGPIO 	EQU 0x400FE608

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
Start		LDR R1 , =SYSCTL_RCGCGPIO
			LDR R0 , [ R1 ]
			ORR R0 , R0 , #0x2;Port B clock enabled
			STR R0 , [ R1 ]
			NOP		;Wait for clock to stabilize
			NOP
			NOP
			LDR R1 , =GPIO_PORTB_DIR ; c o n f i g . o f p o r t B s t a r t s
			LDR R0 , [ R1 ]
			BIC R0 , #0xFF 
			ORR R0 , #IOB;00001111 1->output
			STR R0 , [ R1 ]
			LDR R1 , =GPIO_PORTB_AFSEL
			LDR R0 , [ R1 ]
			BIC R0 , #0xFF
			STR R0 , [ R1 ]
			LDR R1 , =GPIO_PORTB_DEN
			LDR R0 , [ R1 ]
			ORR R0 , #0xFF
			STR R0 , [ R1 ]
			LDR R1 , =GPIO_PORTB_PUR
			LDR R0 , [ R1 ]
			ORR R0 , #0xF0
			STR R0 , [ R1 ]
			
Begin		LDR	R1,=GPIO_PORTB_DATA; Data address in R1
			MOV	R0,#0xFF
			STR	R0,[R1];	All outputs OFF
			
InputCheck	MOV		R2,#15
			LDR 	R0,[R1];
			LSR		R0,#4;
			LSRS	R0,#1;
			ANDCC	R2,#0xFE;
			LSRS	R0,#1;
			ANDCC	R2,#0xFD;
			LSRS	R0,#1;
			ANDCC	R2,#0xFB;
			LSRS	R0,#1;
			ANDCC	R2,#0xF7;
			CMP		R2,#15
			BEQ		InputCheck
			MOV32 	R0,#1600000; 100msec delay
			BL		delay
			MOV		R4,#15
			LDR 	R0,[R1];
			LSR		R0,#4;
			LSRS	R0,#1;
			ANDCC	R4,#0xFE;
			LSRS	R0,#1;
			ANDCC	R4,#0xFD;
			LSRS	R0,#1;
			ANDCC	R4,#0xFB;
			LSRS	R0,#1;
			ANDCC	R4,#0xF7;
			CMP		R2,R4 ; IF they are equal set the output
			BNE		InputCheck
									; If an input is read
			LDR		R1,=GPIO_PORTB_DATA; Data address in R1
			STR		R4,[R1];	Corresponding Outputs set high
			MOV32	R0,#25400000 ;	7Sec
			BL		delay
			B 		Begin
			
;***************************************************************
; End of the program  section
;***************************************************************
;LABEL      DIRECTIVE       VALUE                           COMMENT
			ALIGN
			END