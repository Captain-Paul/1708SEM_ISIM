#include<stdio.h>
#include<math.h>
int main(){
	int x,y;
	printf("��ֱ�����x��y��ֵ��");
	scanf("%d",&x);
	scanf("%d",&y);
	float d;
	d = sqrt(x*x+y*y);
	int e;
	e = round(d); 
	printf("����Ϊ:%d",e);
}
