//6.281-5
#include<stdio.h>
void yrCalc(long tot,int *year,int *month,int *day);
int main(){
	printf("�������1900�굽Ŀǰ��������:");
	long tot;
	int year,month,day;
	scanf("%ld",&tot);
	yrCalc(tot,&year,&month,&day);
	printf("��ǰΪ%d��%d��%d��",year,month,day);
	
}
void yrCalc(long tot,int *year,int *month,int *day){
	*year = 1900 + tot/365;
	tot = tot%365;
	*month = 1+tot/30;
	tot = tot%30;
	*day = 1+tot;
}
