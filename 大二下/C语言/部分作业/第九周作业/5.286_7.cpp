//5.286_7
#include<stdio.h>
#define time 5 //ģ������û����� 
int inverse(int n);

int main(){
	int n;
	int i;
	printf("�������%d�������У�����ǻ������򷵻�1�������򷵻�0\n",time); 
	for(i=0;i<time;i++){
		printf("������һ��������:");
		scanf("%d",&n);
		if(n == inverse(n)){
			printf("1\n");
		}else{
			printf("0\n");
		}
	}
}
int inverse(int n){
	static int temp = 0;
	if(n/10 == 0){
		int re;
		re = temp;
		temp = 0; 
		return re*10+n;
	}else{
		temp = temp*10+n%10;
		return inverse(n/10);
	}
}
