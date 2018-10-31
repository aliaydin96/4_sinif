
number		EQU		31

            AREA        sdata, DATA, READONLY
            THUMB
MSG     	DCB     	0x0
			DCB			0x0D
			DCB			0x04

			AREA    	main, READONLY, CODE
			THUMB
			EXTERN		OutStr
			EXTERN		CONVRT
			EXPORT  	__main	; Make available

__main



Done 	 	B Done


			ALIGN
			END

