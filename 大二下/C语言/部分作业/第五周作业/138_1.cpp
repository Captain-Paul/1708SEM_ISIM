#include<stdio.h>
int main(){
	int numYrs;
	printf("������������:");
	scanf("%d",&numYrs);
	float r;
	if(numYrs>5){
		r = 0.075;
	}else{
		r = 0.054;
	}
	printf("%f",r);
} 
