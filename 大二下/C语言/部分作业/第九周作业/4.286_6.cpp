//4.286_6 
#include<stdio.h>
int gcd(int a,int b);
int main(){
	int a,b;
	printf("����������������:");
	scanf("%d%d",&a,&b);
	if(a>b){
		printf("�������Ϊ:%d",gcd(a,b));
	}else{
		printf("�������Ϊ:%d",gcd(b,a));
	} 
}
int gcd(int a,int b){
	if(a%b == 0){
		return b;
	}
	else{
		return gcd(b,a%b);
	}
}
