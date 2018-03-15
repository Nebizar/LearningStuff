$mod842
org 0	;dydaktyka
	MOV A, #0	;dydaktyka
	MOV R1, #0
STR:	MOV R1, A
GL:		MOV A, R1
		MOV P2, A
		;CALL DELAY
		INC A
		MOV R1, A
		ANL A, #15
		CJNE A, #10, GL
		ANL A, #00110000b
		ADD A, #00000110b
		JMP STR
DELAY:					; Delays by ms 10* A
					; 10mSec based on 2.094MHZ 
					; Core Clock 
					; i.e. default ADuC842 Clock

			MOV R4, #01Bh	; Acc holds delay variable (1 clock)
 DLY0:		MOV	R2,#01Bh		; Set up delay loop0 (2 clocks)
 DLY1:		MOV	R3,#0FFh		; Set up delay loop1 (2 clocks)
		DJNZ	R3,$		; Dec R3 & Jump here until R3 is 0 (3 clocks)
		DJNZ	R2,DLY1         ; Dec R2 & Jump DLY1 until R2 is 0 (3 clocks)
		DJNZ	R4,DLY0		; Dec R1 & Jump DLY0 until R1 is 0 (3 clocks)
		RET

END
