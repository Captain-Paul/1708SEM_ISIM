#include<stdio.h>
#include<math.h>
int main(){
	float A,X,R,N;
	printf("�����ʼ����:");
	scanf("%f",&X);
	printf("�������:");
	scanf("%f",&N);
	printf("����������(�ٷֱ�ǰ������):");
	scanf("%f",&R);
	A = X*pow((1.0+R/100),N);
	printf("%f",A);
	
}
