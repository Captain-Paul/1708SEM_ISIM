//2.275-3b
#include<stdio.h>
void sec(int a,int b,int c,int *totSec);
int main(){
	printf("��������Сʱ�����ӡ�����ȷ����ʱ�䣬��ʽΪ*h*min*s:");
	int a,b,c;
	scanf("%dh%dmin%ds",&a,&b,&c);
	int totSec;
	sec(a,b,c,&totSec);
	printf("������Ϊ:%ds",totSec); 
} 
void sec(int a,int b,int c,int *totSec){
	*totSec = 3600*a+60*b+c;
}
