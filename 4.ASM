;对键盘输入的小写变大写,大写变小写,回车结束
S1	SEGMENT
DATA	DB	100H DUP(?)
S1	ENDS

S2	SEGMENT   STACK
	DW   60H DUP(?)
TOS	LABEL  WORD
S2	ENDS

S3	SEGMENT
	ASSUME DS:S1,SS:S2,CS:S3
MAIN	PROC  FAR
	MOV AX,S1
	MOV DS,AX
	MOV AX,S2
	MOV SS,AX
	LEA SP,TOS

LOP:	MOV	AH,01H
	INT	21H

	CMP AL,0DH
	JE	EXIT
	CMP	AL,'A'
	JB	LOP
	CMP	AL,'Z'
	JA	SMALL
	ADD	AL,20H
	JMP	PRINT

SMALL:	CMP	AL,'a'
	JB	LOP
	CMP	AL,'z'
	JA	LOP
	SUB	AL,20H
	
PRINT:	MOV	DL,AL
	MOV	AH,02H
	INT	21H
	JMP	LOP
EXIT:	MOV	AH,4CH
	INT 	21H

MAIN	ENDP
	S3	ENDS
	END	MAIN