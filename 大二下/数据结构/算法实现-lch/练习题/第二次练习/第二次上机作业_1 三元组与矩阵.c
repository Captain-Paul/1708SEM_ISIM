#include<stdio.h>
int main(){
	printf("��������Ԫ��ĵ�һ�У��ֱ�Ϊ�������������������ͷ�0Ԫ�ظ�����\n");
	int TA[100][3];	//ԭ��Ԫ�� 
	int TB[100][3];//ת�ú���Ԫ�� 
	scanf("%d",&TA[0][0]);
	scanf("%d",&TA[0][1]);
	scanf("%d",&TA[0][2]);
	int i = 1;
	printf("��������Ԫ���2�����һ�У�\n"); 
	while(i<=TA[0][2]){
		scanf("%d",&TA[i][0]);
		scanf("%d",&TA[i][1]);
		scanf("%d",&TA[i][2]);
		i++;
	} 
	
	printf("������ʽΪ��\n");
	int j,k;
	int pointer = 1;
	for(j=0;j<TA[0][0];j++){
		for(k=0;k<TA[0][1];k++){
			if((j==TA[pointer][0]-1) && (k==TA[pointer][1]-1)){
				printf("%d ",TA[pointer][2]);
				pointer++;
			}else{
				printf("%d ",0);
			}
		}
		printf("\n");
	}

	TB[0][0] = TA[0][1];
	TB[0][1] = TA[0][0];
	TB[0][2] = TA[0][2];
	
	int m = 1;
	for(i=1;i<=TA[0][1];i++){
		for(j=1;j<=TA[0][2];j++){
			if(TA[j][1] == i ){
				TB[m][0] = TA[j][1];
				TB[m][1] = TA[j][0];
				TB[m][2] = TA[j][2]; 
				m++;
			}
		}
	
	}
	printf("ת�ú����Ԫ�飺\n");
	for(i=0;i<=TB[0][2];i++){
		for(j=0;j<=2;j++){
			printf("%d ",TB[i][j]);
		}
		printf("\n");
	}
	
	
	
	
	
	
	
	
	printf("ת�ú����Ϊ��\n");
	pointer = 1;
	for(j=1;j<=TB[0][0];j++){
		for(k=1;k<=TB[0][1];k++){
			if((j==TB[pointer][0]) && (k==TB[pointer][1])){
				printf("%d ",TB[pointer][2]);
				pointer++;
			}else{
				printf("%d ",0);
			}
		}
		printf("\n");
	}

	
	
} 
