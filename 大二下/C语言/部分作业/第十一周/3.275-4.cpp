//3.275-4
#include<stdio.h>
void Convert(int *sec,int *hours,int *min,int s);
int main(){
	printf("������������(s):");
	int s;
	scanf("%d",&s);
	int hours,min,sec;
	Convert(&sec,&hours,&min,s);
	printf("ת����ʱ��Ϊ:%dh%dmin%ds",hours,min,sec);
} 
void Convert(int *sec,int *hours,int *min,int s){
	*hours = s/3600;
	s = s%3600;
	*min = s/60;
    *sec = s%60;

}
