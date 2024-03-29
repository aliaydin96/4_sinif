
		AREA	routines, CODE, READONLY
		THUMB	
		EXPORT CONVRT

CONVRT	PROC
		PUSH 	{R0-R4} 		; preserve info in registers
		;STR 	R4, [R0]
		;LDR 	R7, [R4]		;R6=R4
		
		MOV 	R0, #10 		;base value
		MOV 	R1, #0 
		ADD		R7, R4, R1
		MOV 	R2, #0
		MOV 	R3, #0
		
loop1	;loop1 to find, number how many digits have
		UDIV 	R7, R7, R0		;number is divided by 10 since to obtain next digit
		ADD 	R2, #1			;add 1 to counter1 
		ADD 	R3, #1			;add 1 to counter2
		CMP  	R7, #0x0		;
		BEQ 	loop2
		B		loop1
		
loop2	UDIV 	R1, R4, R0 		;number is divided by 10
		MUL	 	R1, R0			;number is multiplied by 10
		SUB	 	R1, R4, R1 		;I subtract R1 from R4 to find first digit of decimal number
		ADD  	R1, #0x30		;to convert ascii string constant, i added 0x30
		SUB	 	R2, #1
		STRB 	R1, [R5, R2]	;store digit in R5
		UDIV 	R4, R4, R0		;number is divided by 10 since to obtain next digit
		CMP  	R4, #0x0
		BEQ 	end_of_operation
		B 		loop2

end_of_operation
		ADD  	R5, R3
		MOV 	R7, #0x04
		MOV 	R3, #0x0D
		STRB 	R3, [R5], #1 	; end of the transmission
		STRB 	R7, [R5]    	;new linE
		POP 	{R0-R4}			;take info on stack
		BX		LR
		ENDP
		ALIGN
		END



