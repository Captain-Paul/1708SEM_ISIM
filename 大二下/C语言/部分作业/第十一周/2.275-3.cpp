//2.275-3a 
#include<stdio.h>
int sec(int a,int b,int c);
int main(){
	printf("��������Сʱ�����ӡ�����ȷ����ʱ�䣬��ʽΪ*h*min*s:");
	int a,b,c;
	scanf("%dh%dmin%ds",&a,&b,&c);
	int totSec;
	totSec = sec(a,b,c);
	printf("������Ϊ:%ds",totSec); 
} 
int sec(int a,int b,int c){
	return 3600*a+60*b+c;
}
