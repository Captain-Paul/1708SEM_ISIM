#include<stdio.h>
#include<math.h>
int main() {
	float h;
	float g = 1.67;
	printf("����������߶�:"); 
	scanf("%f",&h);
	float v;
	int i;
	for(i=0;i<=2;i++){
	v = sqrt(2*g*h);
	printf("��%d������:\n",i+1); 
	printf("v = %f\n",v);
	h = h*2/3;
	printf("h = %f\n",h);
	}
}
