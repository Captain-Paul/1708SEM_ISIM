#include<stdio.h>
int main(){
	char s;
	printf("������һ���ַ�:");
	scanf("%c",&s);
	if(s<='Z'&& s>='A'){
		printf("%d",s-'A'+1);
	}else{
		printf("���Ǵ�д�ַ���");
	}
} 
