//7
#include<stdio.h>
int main(){
	printf("����nֵ:");
	int n;
	scanf("%d",&n);
	int i = 1;
	int sum = 1;
	while(i<=n-1){
		sum = (sum+1)*2;
		i++;
	}
	printf("��������Ϊ:%d",sum);
}
