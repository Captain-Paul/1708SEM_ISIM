#include<stdio.h>
int score(int x);
int main(){
	int A[3];
	printf("���������������������ƣ�����1����A��11����J��12����Q��13����K:");
	scanf("%d%d%d",&A[0],&A[1],&A[2]);
	int Stack[3];
	int Top = -1;
	int i = 0;
	while(i<=2){
		if(A[i] == 1){
			Top++;
			Stack[Top] = A[i];
		}
		i++;
	}
	int sum;
	sum = score(A[0])+score(A[1])+score(A[2]);
	while(sum > 21 && Top > -1){
		sum = sum-10;
		Top--;
	}
	if(score(A[0])==-1||score(A[1])==-1||score(A[2])==-1){
		printf("����Ƿ�����������ȷ�����֣�");
	}
	printf("ֽ������ֵ:%d",sum);
}
int score(int x){
	switch(x){
		case 1:return 11;
		case 2:return 2;
		case 3:return 3;
		case 4:return 4;
		case 5:return 5;
		case 6:return 6;
		case 7:return 7;
		case 8:return 8;
		case 9:return 9;
		case 10:return 10;
		case 11:return 10;
		case 12:return 10;
		case 13:return 10;
		default:return -1;
	}
}

