//5.281-2
#include<stdio.h>
void liquid(int tot,int *gallons,int *quarts,int *pints,int *cups);
int main(){
	int tot,gallons,quarts,pints,cups;
	printf("�������ܱ���:",tot);
	scanf("%d",&tot);
	liquid(tot,&gallons,&quarts,&pints,&cups);
	printf("��%d���أ�%d���ѣ�%dƷ�ѣ�%d��",gallons,quarts,pints,cups);
}
void liquid(int tot,int *gallons,int *quarts,int *pints,int *cups){
	*gallons = tot/16;
	tot = tot%16;
	*quarts = tot/8;
	tot = tot%8;
	*pints = tot/4;
	tot = tot%4;
	*cups = tot;
}
