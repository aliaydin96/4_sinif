ADC0_RIS 		EQU 0x40038004 ; Interrupt status
ADC0_SSFIFO3 	EQU 0x400380A8 ; Channel 3 results
ADC0_PSSI 		EQU 0x40038028 ; Initiate sample
ADC0_ISC		EQU	0x4003800C ; ISC
;LABEL		DIRECTIVE	VALUE		COMMENT
				AREA    	main, READONLY, CODE
				THUMB
				IMPORT		Initialize; Initialize subroutine
				IMPORT		OutChar;
				EXPORT  	__main	; Make available
__main
				BL	Initialize; GPIO & ADC initialized
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
				
				SUB		R0,R2,R6; check sampled data - previous > 0.05
				CMP		R0,#60;
				BGT		move;
				SUB		R0,R6,R2;
				CMP		R0,#60; check previous - sampled data > 0.05
				BLT		getsample;
				
move			MOV		R6,R2;
				MOV		R0,#1241; get the first digit
				UDIV	R1,R2,R0;
				MOV		R5,R1;
				ADD		R5,R5,#0x30; ascii conversion
				PUSH{R0,R1,R2}
				BL		OutChar; print
				POP{R0,R1,R2}
				
				MOV		R5,#0x2E; for '.'
				PUSH{R0,R1,R2}
				BL		OutChar; print
				POP{R0,R1,R2}
				
				MUL		R1,R1,R0;
				SUB		R2,R2,R1; R2 is newed
				MOV		R0,#124; get the second digit
				UDIV	R1,R2,R0;
				MOV		R5,R1;
				ADD		R5,R5,#0x30; ascii conversion
				PUSH{R0,R1,R2}
				BL		OutChar; print
				POP{R0,R1,R2}
				
				MUL		R1,R1,R0;
				SUB		R2,R2,R1; R2 is newed
				MOV		R0,#12; get the last digit
				UDIV	R1,R2,R0;
				MOV		R5,R1;
				ADD		R5,R5,#0x30; ascii conversion
				PUSH{R0,R1,R2}
				BL		OutChar; print
				POP{R0,R1,R2}
				
				MOV		R5,#0x0D; for new line
				PUSH{R0,R1,R2}
				BL		OutChar; print
				POP{R0,R1,R2}
				
				B		getsample;
				
		
				ALIGN
				END