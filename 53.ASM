;����һ�������жϸ�������������1��2��4��5��7��9��10��12��14��16��17��19�� 21��23��25����������������������ڸ����У������YES�������������NO �������������õ��㷨�� �ü����������ķ�������һ�����Ľ���ƽ���������ƽ������һ������������17��ƽ������ ������17��̼�ȥ����1��3��5��7�����������Ϊ������0ʱֹͣ������17-1-3-5-7-9��0�� ���Կ�����17�ڼ�ȥ5������������Ϊ���������Խ�����Ϊ17��ƽ������4��5֮�䡣 25-1-3-5-7-9=0��25��ƽ����Ϊ5��
S1	SEGMENT
ANS	DW	?
NUM	DW	17;��Ҫ�������
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