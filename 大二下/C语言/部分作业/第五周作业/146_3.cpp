#include<stdio.h>
int main(){
	printf("������һ���¶�ֵ������Ӧ�ĵ�λ���м��һ��:");
	float i;
	char s;
	float Celsius,Fahrenheit;
	scanf("%f %c",&i,&s);
	
	if(s == 'f'){
		printf("����Ļ����¶�Ϊ:%f\n",i);
		Fahrenheit = i;
		Celsius = (5.0/9.0)*(Fahrenheit-32.0);
		printf("ת��Ϊ�����¶�Ϊ:%f",Celsius);
	}
	else if(s == 'c'){
		printf("����������¶�Ϊ:%f\n",i);
		Celsius = i;
		Fahrenheit = (9.0/5.0)*Celsius+32.0;
		printf("ת��Ϊ�����¶�Ϊ:%f",Fahrenheit);
	}else{
		printf("����ĳ�����ȷ");
	}
} 

