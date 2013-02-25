;用减奇数次数的方法，求一个数的近似平方根，这个平方根是一个整数。如求17的 
;平方根，可以用17相继减去奇数1、3、5、7、…，当结果为负数时停止，即： 
;
;        17-1-3-5-7-9＜0 
;
;可以看出，17在减去5次奇数后结果变为负数，可以近似认为17的平方根在4 与5之间， 
;计算NUM 的平方根，如果NUM=17，则ANS 中保存结果4。
S1	SEGMENT
ANS	DW	?
NUM	DW	17;需要输入的数
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

	MOV	AX,NUM
	XOR CX,CX;
	MOV	BX,1
L1:	SUB	AX,BX
	JL	PRINT
	INC	CX
	ADD BX,2
	JMP	L1
	MOV	ANS,CX

PRINT:MOV	
	
EXIT:	MOV	AH,4CH
	INT 21H
MAIN ENDP

S3	ENDS
	END	MAIN