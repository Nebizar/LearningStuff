$MOD52
START:	MOV P2,#00000101B
	CALL DELAY
	MOV p2,#00010010B
	CALL DELAY
	MOV P2,#00100110B
	CALL DELAY
	MOV P2,#00110111B
	JMP START

DELAY:					; Delays by ms 10* A
					; 10mSec based on 2.094MHZ 
					; Core Clock 
					; i.e. default ADuC842 Clock

		MOV	R1,#01h		; Acc holds delay variable (1 clock)
 DLY0:		MOV	R2,#01h		; Set up delay loop0 (2 clocks)
 DLY1:		MOV	R3,#01h		; Set up delay loop1 (2 clocks)
		DJNZ	R3,$		; Dec R3 & Jump here until R3 is 0 (3 clocks)
		DJNZ	R2,DLY1         ; Dec R2 & Jump DLY1 until R2 is 0 (3 clocks)
		DJNZ	R1,DLY0		; Dec R1 & Jump DLY0 until R1 is 0 (3 clocks)
		RET
			
END
