#include<stdio.h>
int main(){
	int m;
	printf("����һ������ת��������:"); 
	scanf("%d",&m);
	if(m<=0){
		printf("ERROR INPUT!");
		return -1;
	} 
	printf("���Ϊ:");
	while(m!= 0){
		printf("%d",m%10);
		m = m/10;
	}
}
