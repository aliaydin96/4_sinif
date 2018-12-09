			AREA 	routines, CODE, READONLY
			THUMB
			EXTERN 	Timer0A_Handler
			EXTERN	PULSE_INIT
			EXPORT __main
			
__main	
			BL		PULSE_INIT
			
LOOP		B		LOOP
					
					
					
					