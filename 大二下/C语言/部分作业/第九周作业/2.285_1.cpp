//2.285_1
#include<stdio.h>
int Fib(int n);
int Loop(int n);
int main(){
	int n;
	printf("������������������ǵڼ���:");
	scanf("%d",&n);
	//printf("�õݹ��㷨�ã���%d��Ϊ%d\n",n,Fib(n));
	printf("��ѭ���㷨�ã���%d��Ϊ%d\n",n,Loop(n)); 
}
int Fib(int n){
	if(n==1){
		return 0;
	}
	else if(n==2){
		return 1;
	}
	else if(n>2){
		return Fib(n-2)+Fib(n-1);
	}
}
int Loop(int n){
	int i;
	int a=0,b=1;
	for(i=3;i<=n;i++){
		if(a<b) a = a+b;
		else	b = b+a;
	}
	return a>b?a:b;
}
