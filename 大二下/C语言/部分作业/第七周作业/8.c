#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
#define pi 3.1415926
#define loops 50000
#define lanbuda 3//����ı����lanbuda��ֵ 
double Exp(double theta);
int main(){
	double A[loops];
	int i = 0;
	double sum = 0;

	srand(time(NULL));
	while(i<loops){
		A[i] = Exp(lanbuda);
		sum+=A[i];
		i++;
	}
	printf("����%d������EXP(%d)�������:",loops,lanbuda);
	for(i=0;i<loops;i++){
		printf("%f ",A[i]);
	}
	printf("\n����Ϊ�Ը÷ֲ��ļ���:\n");
	double E;
	E = 1.0*sum/loops;
	printf("����Ϊ%d��ָ���ֲ�����ѧ����Ϊ:%f",lanbuda,E);
	
	
}
double Exp(double theta){
	double x;
	double m;
	m = (double)(rand()%1000)/1000;
	while(m==0){
		m = (double)(rand()%1000)/1000;
	}
	x = (-1.0/theta)*(log(1-m));
	return x;
}
