#include<stdio.h>
int main(){
	int i;
	printf("������һ������:");
	scanf("%d",&i);
	switch(i){
		case 1:printf("3M��˾");break;
		case 2:printf("��ʤ��˾");break;
		case 3:printf("���ṫ˾");break;
		case 4:printf("������˾");break;
		default:printf("input error"); 
	}
} 
