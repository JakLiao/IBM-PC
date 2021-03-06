;试编写一段程序，求出首地址为DATA 的100个字数组中的最小偶数，并把它存放 在AX中
S1	SEGMENT
DATA	DW	100H DUP(?)
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
	
	MOV CX,100
	XOR SI,SI
	MOV AX,0FFH
START:	MOV DX,DATA[SI]
	MOV BX,DX
	SHR BX,1;通过最低位判断奇偶
	JC	RETURN;奇数则继续下个数
	CMP AX,DX
	JB	RETURN
	MOV	AX,DX;最小的偶数
	
RETURN:	ADD SI,2
	LOOP	START
	
PRINT:	XOR CX,CX;十进制输出结果
L1:	XOR DX,DX
	MOV BX,10
	DIV BX
	PUSH DX
	INC CX
	CMP AX,0
	JNE	L1
L2:	POP	DX
	ADD DL,30H
	MOV AH,02H
	INT 21H
	LOOP L2

EXIT:	MOV	AH,4CH
	INT 	21H

MAIN	ENDP
	S3	ENDS
	END	MAIN