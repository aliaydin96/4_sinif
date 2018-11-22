
; Your SystemTimer . s sour c e f i l e to implement
; i n i t i a l i z a t i o n and ISR

; De f i n i t i o n o f the l abe s s tanding f o r
; the addr e s s o f the r e g i s t e r s
NVIC_ST_CTRL 	EQU 0xE000E010
NVIC_ST_RELOAD 	EQU 0xE000E014
NVIC_ST_CURRENT EQU 0xE000E018
SHP_SYSPRI3 	EQU 0xE000ED20
; end o f the r e g i s t e r l a b e l d e f i n i t i o n s
; 0x7D0 = 2000 ??> 2000*250 ns = 500mus
RELOAD_VALUE 	EQU 0x000007D0

; I n i t i a l i z a t i o n ar ea

;LABEL DIRECTIVE VALUE COMMENT
	AREA initisr , CODE, READONLY, ALIGN=2
	THUMB
	EXPORT InitSysTick
InitSysTick PROC
; f i r s t d i s a b l e system t imer and the r e l a t e d i n t e r r u p t
; then c o n f i g u r e i t to use i s t e r n a l o s c i l l a t o r PIOSC/4
	LDR R1 , =NVIC_ST_CTRL
	MOV R0 , #0
	STR R0 , [R1 ]
	; now s e t the time out pe r iod
	LDR R1 , =NVIC_ST_RELOAD
	LDR R0 , =RELOAD_VALUE
	STR R0 , [R1 ]
	; time out pe r i od i s s e t
	; now s e t the cur r ent t imer value to the time out value
	LDR R1 , =NVIC_ST_CURRENT
	STR R0 , [R1 ]
	; cur r ent t imer = time out pe r iod
	; now s e t the p r i o r i t y l e v e l
	LDR R1 , =SHP_SYSPRI3
	MOV R0 , #0x40000000
	STR R0 , [R1 ]
	; p r i o r i t y i s s e t to 2
	; now enabl e system t imer and the r e l a t e d i n t e r r u p t
	LDR R1 , =NVIC_ST_CTRL
	MOV R0 , #0x03
	STR R0 , [R1 ]
	; s e t up f o r system time i s now complete
	ENDP
	END