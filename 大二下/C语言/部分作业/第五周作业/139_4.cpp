#include<stdio.h>
int main(){
	char status;
	int high = 800;
	int low = 375;
	printf("������һ���ַ�:");
	scanf("%c",&status);
	if(status == 's'){
		printf("%d",high);
	}else{
		printf("%d",low);
	}
}
