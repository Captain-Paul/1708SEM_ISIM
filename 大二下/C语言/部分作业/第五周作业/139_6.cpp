#include<stdio.h>
#include<math.h> 
int main(){
	float a,b,c,area;
	printf("��ֱ����������ε�����:");
	scanf("%f%f%f",&a,&b,&c);
	float s;
	s = (a+b+c)/2;
	area = sqrt(s*(s-a)*(s-b)*(s-c));
	if(area<=0){
		printf("�����������޷����һ��������");
	}else{
		printf("���Ϊ:%f",area);
	}
}
//���ϸ��ĺ��׹�ʽ���˰ɣ��� 
