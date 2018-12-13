ADC0_RIS 		EQU 0x40038004 ; Interrupt status
ADC0_SSFIFO3 	EQU 0x400380A8 ; Channel 3 results
ADC0_PSSI 		EQU 0x40038028 ; Initiate sample
ADC0_ISC		EQU	0x4003800C ; ISC
;LABEL		DIRECTIVE	VALUE		COMMENT
				AREA    	main, READONLY, CODE
				THUMB
				IMPORT		Init_ADC; Initialize subroutine
				EXPORT  	__main	; Make available
__main
				BL	Init_ADC; GPIO & ADC initialized
				MOV		R6,#0;
getsample		LDR		R1,=ADC0_PSSI; request a sample
				LDR		R2,[R1];
				ORR		R2,R2,#0x08; get a sample
				STR		R2,[R1];
				
loop			LDR		R1,=ADC0_RIS; check for interrup flag
				LDR		R2,[R1];
				ANDS	R2,#0x08;
				BEQ		loop
				
				LDR		R1,=ADC0_ISC; clear the interrupt flag
				LDR		R2,[R1];
				ORR		R2,#0x08;
				STR		R2,[R1]; Interrupt flag is cleared
				
				LDR		R1,=ADC0_SSFIFO3;
				LDR		R2,[R1]; R2 is the data
				
				
move			
				MOV		R0,#1241; get the first digit
				UDIV	R7,R2,R0;
				MOV		R1, R7
				
				MUL		R1,R1,R0;
				SUB		R2,R2,R1; R2 is newed
				MOV		R0,#124; get the second digit
				UDIV	R8,R2,R0;
				MOV		R1, R8
				
				MUL		R1,R1,R0;
				SUB		R2,R2,R1; R2 is newed
				MOV		R0,#12; get the last digit
				UDIV	R9,R2,R0;
				
				B		getsample;
				
		
				ALIGN
				END