#include<stdio.h>
int main(){
	printf("��������Ԫ��TA�ĵ�һ�У��ֱ�Ϊ�������������������ͷ�0Ԫ�ظ�����\n");
	int TA[100][3];	
	int TB[100][3];
	scanf("%d",&TA[0][0]);
	scanf("%d",&TA[0][1]);
	scanf("%d",&TA[0][2]);
	int i = 1;
	printf("��������Ԫ��TA��2�����һ�У�\n"); 
	while(i<=TA[0][2]){
		scanf("%d",&TA[i][0]);
		scanf("%d",&TA[i][1]);
		scanf("%d",&TA[i][2]);
		i++;
	}
	
	printf("��������Ԫ��TB�ĵ�һ�У��ֱ�Ϊ�������������������ͷ�0Ԫ�ظ���(Ҫ����TA��������ͬ)��\n");
	scanf("%d",&TB[0][0]);
	scanf("%d",&TB[0][1]);
	scanf("%d",&TB[0][2]);
	i = 1;
	printf("��������Ԫ��TB��2�����һ�У�\n"); 
	while(i<=TB[0][2]){
		scanf("%d",&TB[i][0]);
		scanf("%d",&TB[i][1]);
		scanf("%d",&TB[i][2]);
		i++;
	}
	
	int TC[100][3];
	TC[0][0] = TA[0][0];
	TC[0][1] = TA[0][1];
	int j = 1,k = 1;
	i = 1;
	while(j<=TA[0][2] && k<=TB[0][2]){
		if(TA[j][0] == TB[k][0]){
			if(TA[j][1] == TB[k][1]){
				if(TA[j][2]+TB[k][2]!=0){
					TC[i][0] = TA[j][0];
					TC[i][1] = TA[j][1];
					TC[i][2] = TA[j][2]+TB[k][2];
					i++;j++;k++; 
				}
				else{
					j++;k++;
				}
			}
			
			else if(TA[j][1] <= TB[k][1]){
				TC[i][0] = TA[j][0];
				TC[i][1] = TA[j][1];
				TC[i][2] = TA[j][2];
				j++;i++;
			}
			else if(TA[j][1] >= TB[k][1]){
				TC[i][0] = TB[k][0];
				TC[i][1] = TB[k][1];
				TC[i][2] = TB[k][2];
				k++;i++;
			}
		}
		else if(TA[j][0] >= TB[k][0]){
			TC[i][0] = TB[k][0];
			TC[i][1] = TB[k][1];
			TC[i][2] = TB[k][2];
			k++;i++;
		}
		else if(TA[j][0] <= TB[k][0]){
			TC[i][0] = TA[j][0];
			TC[i][1] = TA[j][1];
			TC[i][2] = TA[j][2];
			j++;i++;
		}
	}
	while(j<=TA[0][2]){
		TC[i][0] = TA[j][0];
		TC[i][1] = TA[j][1];
		TC[i][2] = TA[j][2];
		j++;i++;
	}
	while(k<=TB[0][2]){
		TC[i][0] = TB[k][0];
		TC[i][1] = TB[k][1];
		TC[i][2] = TB[k][2];
		k++;i++;
	}
	
	TC[0][2] = i-1;
	printf("�������Ԫ��Ϊ��\n");
	for(i=0;i<=TC[0][2];i++){
		for(j=0;j<=2;j++){
			printf("%d ",TC[i][j]);
		}
		printf("\n");
	}	
}
