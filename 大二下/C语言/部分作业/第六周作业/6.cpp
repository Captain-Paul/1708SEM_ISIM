#include<stdio.h>
#define MAXNUM 100000
#define MIN 0
#define MAX 10000000.0
int main(){
	double A[MAXNUM];
	int i=0;
	double min = MAX;
	double max = MIN;
	while (true){
		printf("������һ��������");
		scanf("%lf",&A[i]);
		if(A[i]<=0){
			break;
		}
		if(A[i]<min) min = A[i];
		if(A[i]>max) max = A[i];
		i++;
	}
	printf("���Ǹ���Ϊ:%f",max);
	printf("��С�Ǹ���Ϊ:%f",min);
	
	
	
} 
