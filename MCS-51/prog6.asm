$MOD842
ORG 0
	JMP MAIN
ORG 03h
	JMP INTER

MAIN:
	SETB EA
	SETB EX0
LOOP:	MOV P2, #10000001B
		CALL DELAY
		JMP LOOP
	
	
INTER:
	MOV R4, #30
	MOV R5, #3
	MOV P2, #01000001B
	CALL DELAY
	MOV P2, #00010001B
	CALL DELAY
	CALL DELAY
GREEN:
	MOV P2, #00011000B
	CALL DELAY
	DJNZ R4, GREEN
MRYG:
	MOV P2, #00010000B
	CALL DELAY2
	MOV P2, #00011000B
	CALL DELAY2
	DJNZ R5, MRYG
	MOV P2, #00010001B
	CALL DELAY
	CALL DELAY
	MOV P2, #01000001B
	CALL DELAY
	RETI

DELAY:					; Delays by ms 10* A
					; 10mSec based on 2.094MHZ 
					; Core Clock 
					; i.e. default ADuC842 Clock

		MOV	R1,#0Fh		; Acc holds delay variable (1 clock)
 DLY0:		MOV	R2,#0Fh		; Set up delay loop0 (2 clocks)
 DLY1:		MOV	R3,#0FFh		; Set up delay loop1 (2 clocks)
		DJNZ	R3,$		; Dec R3 & Jump here until R3 is 0 (3 clocks)
		DJNZ	R2,DLY1         ; Dec R2 & Jump DLY1 until R2 is 0 (3 clocks)
		DJNZ	R1,DLY0		; Dec R1 & Jump DLY0 until R1 is 0 (3 clocks)
		RET
DELAY2:					; Delays by ms 10* A
					; 10mSec based on 2.094MHZ 
					; Core Clock 
					; i.e. default ADuC842 Clock

		MOV	R1,#0Fh		; Acc holds delay variable (1 clock)
 DLY01:		MOV	R2,#0Fh		; Set up delay loop0 (2 clocks)
 DLY11:		MOV	R3,#0F1h		; Set up delay loop1 (2 clocks)
		DJNZ	R3,$		; Dec R3 & Jump here until R3 is 0 (3 clocks)
		DJNZ	R2,DLY11         ; Dec R2 & Jump DLY1 until R2 is 0 (3 clocks)
		DJNZ	R1,DLY01		; Dec R1 & Jump DLY0 until R1 is 0 (3 clocks)
		RET			
END
