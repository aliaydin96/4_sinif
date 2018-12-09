FIRST	   		EQU	0x20000480
;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	main, READONLY, CODE
			THUMB
			EXTERN		PULSE_INIT		; Pulse initialization	
			EXPORT  	__main	; Make available

__main
			BL	PULSE_INIT; initialize pulse
			MOV	R6,#0
			CPSIE	I
			;PUSH{R6}
loop		B	loop;

			ALIGN
			END
