//7
#include<stdio.h>
void larger_of(double *x,double *y);
int main(){
	double x,y;
	printf("������x:");
	scanf("%lf",&x);
	printf("������y:");
	scanf("%lf",&y);
	larger_of(&x,&y);
	printf("�޸ĺ������ֵΪ:x=%lf,y=%lf",x,y);
	 
} 
void larger_of(double *x,double *y){
	if(*x > *y){
		*y = *x;
	}else{
		*x = *y;
	}
}
