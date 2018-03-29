$MOD842
ORG 0
	JMP MAIN
ORG 03H
	JMP INTER
	
MAIN:
	SETB EA
	SETB EX0
	MOV R6, #3
	MOV R1, #00000000b
	MOV R2, #00010000b
	MOV R7, #0
LOOP:
	CJNE R7, #0, LOOP2
	MOV P2, R1
	CALL DELAY
	MOV P2, R2
	CALL DELAY2
	MOV A, R1
	INC A
	MOV R1, A
	CJNE A, #00001010b, LOOP
	MOV R1, #00000000b
	MOV A, R2
	INC A
	MOV R2, A
	CJNE A, #00011010B, LOOP
	MOV R2, #00010000B
	JMP LOOP
LOOP2:
	CJNE R7, #0FFh, LOOP
	MOV P2, R1
	CALL DELAY
	MOV P2, R2
	CALL DELAY2
	MOV A, R1
	DEC A
	MOV R1, A
	CJNE A, #11111111b, LOOP2
	MOV R1, #00001001b
	MOV A, R2
	DEC A
	MOV R2, A
	CJNE A, #00001111B, LOOP2
	MOV R2, #00011001B
	JMP LOOP2
	

INTER:
	DJNZ R6, BACK
	MOV A, R7
	CPL A
	MOV R7, A
	MOV R6, #3
BACK:
	RETI

DELAY:					; Delays by ms 10* A
					; 10mSec based on 2.094MHZ 
					; Core Clock 
					; i.e. default ADuC842 Clock

			MOV R4, #0Fh	; Acc holds delay variable (1 clock)
 DLY0:		MOV	R5,#0Fh		; Set up delay loop0 (2 clocks)
 DLY1:		MOV	R3,#0Fh		; Set up delay loop1 (2 clocks)
		DJNZ	R3,$		; Dec R3 & Jump here until R3 is 0 (3 clocks)
		DJNZ	R5,DLY1         ; Dec R2 & Jump DLY1 until R2 is 0 (3 clocks)
		DJNZ	R4,DLY0		; Dec R1 & Jump DLY0 until R1 is 0 (3 clocks)
		RET
		
DELAY2:					; Delays by ms 10* A
					; 10mSec based on 2.094MHZ 
					; Core Clock 
					; i.e. default ADuC842 Clock

			MOV R4, #3Fh	; Acc holds delay variable (1 clock)
 DLY01:		MOV	R5,#3Fh		; Set up delay loop0 (2 clocks)
 DLY11:		MOV	R3,#3Fh		; Set up delay loop1 (2 clocks)
		DJNZ	R3,$		; Dec R3 & Jump here until R3 is 0 (3 clocks)
		DJNZ	R5,DLY11         ; Dec R2 & Jump DLY1 until R2 is 0 (3 clocks)
		DJNZ	R4,DLY01	; Dec R1 & Jump DLY0 until R1 is 0 (3 clocks)
		RET
END