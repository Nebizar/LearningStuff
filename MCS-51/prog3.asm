$mod842
MOV R1, #10000000b
MOV R2, #10010000b
MOV R3, #10100000b
MOV R4, #10110000b
LOOP:
	MOV P2, R1
	CALL DELAY
	MOV P2, R2
	CALL DELAY
	MOV P2, R3
	CALL DELAY
	MOV P2, R4
	CALL DELAY
	JNB P2.7, STOP
	MOV A, R1
	INC A
	MOV R1, A
	CJNE A, #10001010b, LOOP
	MOV R1, #10000000b
	MOV A, R2
	INC A
	MOV R2, A
	CJNE A, #10011010B, LOOP
	MOV R2, #10010000B
	MOV A, R3
	INC A
	MOV R3, A
	CJNE A, #10101010B, LOOP
	MOV R3, #10100000B
	MOV A, R4
	INC A
	MOV R4, A
	CJNE A, #10111010B, LOOP
	MOV R4, #10110000B
	JMP LOOP

STOP:
	MOV P2, R1
	CALL DELAY
	MOV P2, R2
	CALL DELAY
	MOV P2, R3
	CALL DELAY
	MOV P2, R4
	CALL DELAY
	JNB P2.7, LOOP
	JMP STOP

	
DELAY:					; Delays by ms 10* A
					; 10mSec based on 2.094MHZ 
					; Core Clock 
					; i.e. default ADuC842 Clock

		MOV	R5,#0Fh		; Acc holds delay variable (1 clock)
 DLY0:		MOV	R6,#0Fh		; Set up delay loop0 (2 clocks)
 DLY1:		MOV	R7,#0Fh		; Set up delay loop1 (2 clocks)
		DJNZ	R7,$		; Dec R3 & Jump here until R3 is 0 (3 clocks)
		DJNZ	R6,DLY1         ; Dec R2 & Jump DLY1 until R2 is 0 (3 clocks)
		DJNZ	R5,DLY0		; Dec R1 & Jump DLY0 until R1 is 0 (3 clocks)
		RET
		
END
	