


			AREA    	main, READONLY, CODE
			THUMB
			EXTERN		OutStr
			EXPORT  	CONVRT		; Make available

CONVRT
			MOV32 R4, #number
			ORR	R4, #0x0
			LDR	R5, [R4]
			BL	OutStr
Done 	 	B Done


			ALIGN
			END