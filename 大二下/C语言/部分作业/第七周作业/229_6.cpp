#include<stdio.h>
int C_function(int n,int m);
int main(){
	int n,m;
	printf("�������������m����ѡ���ĸ���n:\n");
	printf("m = ");
	scanf("%d",&m);
	printf("n = ");
	scanf("%d",&n);
	if(m<n){
		printf("INPUT ERROR!");
		return -1; 
	}
	printf("���ܵ���Ŀ:%d",C_function(n,m));
} 
int C_function(int n,int m){
	int top = 1;
	int bottom = 1;
	int i;
	for(i=1;i<=n;i++){
		top = top*(m-i+1);
		bottom = bottom*i;
	}
	return top/bottom;
}

