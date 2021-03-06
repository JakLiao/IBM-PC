;从键盘上输入一系列以$为结束符的字符串，然后对其中的非数字字符计数，并显示计数结果
S1	SEGMENT
DATA	DB	100H DUP(?)
CRLF	DB  0DH,0AH,24H
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

START:
	XOR BX,BX
INPUT:	MOV AH,01H
	INT 21H
	CMP	AL,24H
	JE	OUTPUT
	CMP	AL,0DH
	JE	EXIT
	CMP	AL,30H
	JB	L1
	CMP AL,39H
	JA	L1
	JMP	INPUT
L1:	INC BX
	JMP	INPUT
	
OUTPUT:	LEA DX,CRLF
	MOV AH,09H
	INT 21H
	
	XOR CX,CX;十进制输出
	MOV AX,BX
L2:	XOR DX,DX
	MOV BX,10
	DIV	BX
	PUSH DX
	INC CX
	CMP AX,0
	JNE L2
	
L3:	POP DX
	ADD DL,30H
	MOV	AH,02H
	INT 21H
	LOOP L3
	
	LEA DX,CRLF
	MOV AH,09H
	INT 21H
	JMP	START
EXIT:	MOV	AH,4CH
	INT 	21H

MAIN	ENDP
	S3	ENDS
	END	MAIN