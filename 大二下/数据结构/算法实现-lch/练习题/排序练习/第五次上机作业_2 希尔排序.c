#include<stdio.h>
void Shell_arrange(int A[],int n);
int main(){
	int n;
	printf("��������Ҫ�����Ԫ�ظ���:");
	scanf("%d",&n);
	printf("������Ҫ���������:");
	int A[n];
	int i;
	for(i=0;i<n;i++){
		scanf("%d",&A[i]);
	}
	printf("ϣ��������Ϊ:");
	Shell_arrange(A,n);
	for(i=0;i<n;i++){
		printf("%d ",A[i]);
	}
}
void Shell_arrange(int A[],int n){
	int i,j;
	int d,temp;
	d = n;
	while(d>1){
		d = d/2;
		for(i=d;i<n;i++){
			temp = A[i];
			j = i-d;
			while(j>=0 && temp>A[j]){
				A[j+d] = A[j];
				j = j - d;
			}
			A[j+d] = temp;
		}
	}
} 
