#include<stdio.h>
int main(){
	char s;
	printf("������һ���ַ�:");
	scanf("%c",&s);
	if(s<='z'&& s>='a'){
		printf("%d",s-'a'+1);
	}else{
		printf("����Сд�ַ���");
	}
} 
