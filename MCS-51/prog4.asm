$mod842
ORG 0
	JMP MAIN
ORG 03H
	JMP INTER
	
MAIN:
MOV IE, #81
MOV R0, #5
LOOP: 
	MOV P2, #00000001B
	;DEC R0
	CALL DELAY
	MOV P2, #00000010B
	;DEC R0
	CALL DELAY
	MOV P2, #00000100B
	;DEC R0
	CALL DELAY
	MOV P2, #00001000B
	;DEC R0
	CALL DELAY
	DJNZ R0, LOOP
	
INTER:
	MOV P2, #00001000B
	;DEC R0
	CALL DELAY
	MOV P2, #00000100B
	;DEC R0
	CALL DELAY
	MOV P2, #00000010B
	;DEC R0
	CALL DELAY
	MOV P2, #00000001B
	;DEC R0
	CALL DELAY
	RETI

DELAY:					; Delays by ms 10* A
					; 10mSec based on 2.094MHZ 
					; Core Clock 
					; i.e. default ADuC842 Clock

		MOV	R1,#0Fh		; Acc holds delay variable (1 clock)
 DLY0:		MOV	R2,#0Fh		; Set up delay loop0 (2 clocks)
 DLY1:		MOV	R3,#0Fh		; Set up delay loop1 (2 clocks)
		DJNZ	R3,$		; Dec R3 & Jump here until R3 is 0 (3 clocks)
		DJNZ	R2,DLY1         ; Dec R2 & Jump DLY1 until R2 is 0 (3 clocks)
		DJNZ	R1,DLY0		; Dec R1 & Jump DLY0 until R1 is 0 (3 clocks)
		RET
			
END