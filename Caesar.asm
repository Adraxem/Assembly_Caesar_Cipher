
ORG 0000

KNOWNC EQU 'U'

INDEX EQU 0

ENCODEDLEN EQU 5

CLR A
MOV DPTR, #ALPHABET
MOV B, #KNOWNC
MOV R0, #01AH
MOV R1, #01AH
	RETRY:
	CLR A
	MOVC A,@A+DPTR
	CJNE A, B, IF
	PUSH ACC
;	MOV A,R0
;	SUBB A, R1
	SJMP NEXT1

	
	IF: INC DPTR
	DEC R1
	SJMP RETRY

NEXT1: PUSH ACC
POP 0
POP ACC



DIFF:
	MOV DPTR, #ENCODED
	MOV R2, #INDEX
	PUSH ACC
	CLR A
	MOV A,R2
	MOVC A,@A+DPTR
	CJNE A,B,NEXT3
	LJMP TARGET7
;	SUBB A,B
;	MOV R3,A
;	MOV R6,A
	SJMP TILL
NEXT3:
	PUSH ACC
	SUBB A,B
	PUSH ACC
	MOV R0, A
	CLR A
	SUBB A,R0
	MOV R3, A
	POP ACC
	POP B
	PUSH 3
	CLR C
	CLR AC
	CJNE R3, #0E0H,DIFF2

DIFF2:JNC SKIP
JC TILL
SKIP:
MOV B,R3
MOV A,#0FFH
SUBB A,B
ADD A, #01H
MOV B, A
MOV A, #01AH
SUBB A,B
MOV R3,A
MOV R6,A

TILL:
MOV A,R3
MOV R6,A
CH3:
MOV R1,#000H
DECRYPTION:
CLR A
CLR C
CLR AC
ADD A,R1
INC R1
INC R5
MOV DPTR,#ENCODED
MOVC A,@A+DPTR
MOV B,A
JZ KILL
MOV DPTR, #ALPHABET

	ITERATE:
	CLR A
	MOVC A,@A+DPTR
	CJNE A,B,NEXT
	PUSH ACC
	ADD A,R3
	CJNE A,#05AH,FILL

	ADDITION:
	CLR A
	INC DPTR
	MOVC A,@A+DPTR
	DJNZ R3,ADDITION
	SJMP FINAL

	FILL: JC ADDITION
	MOV A,R4
	ADD A,R3
	MOV B, #01AH
	DIV AB
	SJMP ITERATEOUT


	NEXT: INC DPTR
	INC R4
	SJMP ITERATE
KILL:

JMP KILLF
ITERATEOUT:
MOV R0,B
MOV DPTR,#ALPHABET
TARGET:
CLR A
INC DPTR
MOVC A,@A+DPTR
DJNZ R0,TARGET


FINAL:
MOV R4,#00H
PUSH ACC
MOV A,R6
MOV R3,A
POP ACC
MOV R0, #040H
PUSH ACC
MOV A,R5
ADD A,R0
MOV R0,A
POP ACC
MOV @R0,A

SJMP DECRYPTION




;	DEC R0
;	MOV 3,@R0
;	DEC R0
;	MOV 4,@R0
;	DEC R0
;	MOV 5,@R0
;	DEC R0
;	MOV 6,@R0
;	DEC R0
;	MOV 7,@R0
TARGET7: MOV R1,#40H
CASE:
CLR A
MOVC A,@A+DPTR
MOV @R1,A
INC R1
INC DPTR
JNZ CASE


KILLF:

CLR A
MOV R1,#040H
MOV A, #38H
ACALL COMNWRT
ACALL DELAY
MOV A,#0EH
ACALL COMNWRT
ACALL DELAY
MOV A,#01H
ACALL COMNWRT
ACALL DELAY
MOV A,#01H
ACALL COMNWRT
ACALL DELAY
MOV A,#84H
ACALL COMNWRT
ACALL DELAY
MOV A, @R1
INC R1
ACALL DATAWRT
ACALL DELAY
MOV A,@R1
INC R1
ACALL DATAWRT
ACALL DELAY
MOV A,@R1
INC R1
ACALL DATAWRT
ACALL DELAY
MOV A,@R1
INC R1
ACALL DATAWRT
ACALL DELAY
MOV A,@R1
INC R1
ACALL DATAWRT
ACALL DELAY
MOV A,@R1
INC R1
ACALL DATAWRT
ACALL DELAY
MOV A,@R1
INC R1
ACALL DATAWRT
ACALL DELAY
MOV A,@R1
INC R1
ACALL DATAWRT
ACALL DELAY
MOV A,@R1
INC R1
ACALL DATAWRT
ACALL DELAY
MOV A,@R1
INC R1
ACALL DATAWRT
ACALL DELAY
MOV A,@R1
INC R1
ACALL DATAWRT
ACALL DELAY
MOV A,@R1
INC R1
ACALL DATAWRT
ACALL DELAY
MOV A,@R1
INC R1
ACALL DATAWRT
ACALL DELAY
MOV A,@R1
INC R1
ACALL DATAWRT
ACALL DELAY
MOV A,@R1
INC R1
ACALL DATAWRT
AGAIN: SJMP AGAIN

COMNWRT:
MOV P1,A
CLR P2.0
CLR P2.1
SETB P2.2
ACALL DELAY
CLR P2.2
RET

DATAWRT:
MOV P1,A
SETB P2.0
CLR P2.1
SETB P2.2
ACALL DELAY
CLR P2.2
RET

DELAY: MOV R3, #1
HERE2: MOV R4,#10
HERE: DJNZ R4, HERE
DJNZ R3,HERE2
RET

LASTKILL:








ORG 160H
ENCODED: DB 'SIUUU',0H

ORG 250H
ALPHABET: DB 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H','I', 'J', 'K', 'L', 'M', 'N', 'O', 'P','Q', 'R','S', 'T', 'U', 'V','W','X', 'Y', 'Z'


;ORG 100H
;LCD: DB 77H, 7CH, 39H, 5EH, 79H, 71H, 5FH, 76H, 30H, 0EH, 70H, 38H, 15H, 54H, 3FH, 73H, 67H, 50H, 6DH, 78H, 3EH, 1CH, 2AH, 76H, 6EH, 5BH

;A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z

END