//1
#include<stdio.h>
void inverse(int n);

int main(){
	int n;
	printf("������һ��������:");
	scanf("%d",&n);
	printf("�����:");
	inverse(n);
} 
void inverse(int n){
	
	if(n/10 == 0){
		printf("%d",n);
	}else{
		printf("%d",n%10);
		inverse(n/10);
	}
}
