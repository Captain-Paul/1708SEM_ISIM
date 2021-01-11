#include<stdio.h>
#include<limits.h>
#define MaxValue INT_MAX
#define MaxNum 100
void print(int n,int A[][MaxNum]);//��ӡ�ڽӾ��� 
void PRIM(int A[][MaxNum],int n);//Prim��С������ ���㷨û���Ǹ���
void BFS(int A[][MaxNum],int n); //����������� 
int main(){
	int i,j,k,weight;
	int n,e;
	printf("���������ά��:");
	scanf("%d",&n);
	printf("���������:");
	scanf("%d",&e);
	int A[MaxNum][MaxNum];
	for(i=0;i<n;i++){
		for(j=0;j<n;j++){
			A[i][j] = MaxValue;
		}
	}
	for(k=0;k<e;k++){
		printf("��ֱ�����ö������ڽӾ����λ�ü���Ȩֵ(ע��λ�ô�1��ʼ):"); 
		scanf("%d%d%d",&i,&j,&weight);
		A[i-1][j-1] = weight;
		A[j-1][i-1] = weight; 
	}
	print(n,A);
	//PRIM(A,n);
	BFS(A,n);
	
}
void print(int n,int A[][MaxNum]){
	int i,j;
	for(i=0;i<n;i++){
		for(j=0;j<n;j++){
			/*if(A[i][j] == MaxValue){
				A[i][j] = 0;
			}*/
			printf("%2d ",A[i][j]);
		}
		printf("\n");
	}
} 
void PRIM(int A[][MaxNum],int n){
	int lowcost[n],relate[n];
	int i,j,k,mincost;
	lowcost[0] = 0;
	relate[0] = 0;
	for(i=1;i<n;i++){
		relate[i] = 0;
		lowcost[i] = A[0][i];
	}
	for(i=1;i<n;i++){
		mincost = MaxValue;
		
		for(j=0;j<n;j++){
			if(lowcost[j]>0 && mincost > lowcost[j]){
				mincost = lowcost[j];
				k = j; 
			}
		}
		lowcost[k] = 0;
		for(j=0;j<n;j++){
			
			if(A[k][j]<lowcost[j]){
				lowcost[j] = A[k][j];
				relate[j] = k;
			}
			
		}
		
	}
	for(k=0;k<n;k++){
		printf("%d ",lowcost[k]);
		printf("%d\n",relate[k]);
		}
	
} 
void BFS(int A[][MaxNum],int n){
	int Queue[MaxNum];
	int front = -1;
	int rear = -1;
	int i = 0;
	int j;
	int k;
	int Mark[n];
	Queue[++rear] = 1;
	for(k=0;k<n;k++){
		Mark[k] = 0;
	}
	
	for(k=0;k<n;k++){
		front++;
		i = Queue[front];
		for(j=0;j<n;j++){
			if(Mark[j]==1){
				continue;
			}
			else{
				if(A[i-1][j]<MaxValue){
					Queue[++rear] = j+1;
				}
			}
		}
		Mark[i-1] = 1;
	}
	for(i=0;i<n;i++){
		printf("%d ",Queue[i]);
	} 
}

