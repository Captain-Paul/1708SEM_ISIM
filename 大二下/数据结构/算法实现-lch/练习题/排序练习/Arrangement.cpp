#include<stdio.h>
#define n 9
void Select(int A[]); //ѡ������
void Bubble(int A[]); //ð������ 
void Linear_Insert(int A[]); //���Բ������� 
void Bin_Sort(int A[]);//�۰�������� 
void Shell_arrange_1(int A[]);//ϣ����Ƕ��������
void Shell_arrange_2(int A[]);//ϣ����Ƕð������
void Quick_sort(int A[],int low,int high);//�������� 

void Heap_Adjust(int A[],int i,int m);//������ (����������0����n-1���±꣬�ʱ䶯�ܴ�) 
void Heap_Sort(int A[]);

void Merge(int A[],int s,int t,int u,int Z[]);
void MPASS(int A[],int B[],int m,int t);
void MSORT(int A[],int B[]);//��·�鲢

void Base_Sort(int A[],int B[]);//�������� 

void Linear_Search(int A[],int K);//˳�����
void Bin_Search(int A[],int K);//�۰���� 
int main(){
	int i,j;
	int	A[] = {5,3,1,7,8,6,2,4,9};
	Select(A);
	printf("ѡ��������Ϊ:");
	for(i=0;i<n;i++){
		printf("%d ",A[i]);
	}
	printf("\n"); 
	
	int	B[] = {5,3,1,7,8,6,2,4,9};
	Bubble(B);
	printf("ð��������Ϊ:");
	for(i=0;i<n;i++){
		printf("%d ",B[i]);
	}
	printf("\n");
	
	int	C[] = {5,3,1,7,8,6,2,4,9};
	Linear_Insert(C);
	printf("���Բ���������Ϊ:");
	for(i=0;i<n;i++){
		printf("%d ",C[i]);
	}
	printf("\n");
	
	int	D[] = {1,2,3,4,5,6,7,9,8};
	Bin_Sort(D);
	printf("�۰����������Ϊ:");
	for(i=0;i<n;i++){
		printf("%d ",D[i]);
	}
	printf("\n");
	
	int	E[] = {5,3,1,7,8,6,2,4,9};
	Shell_arrange_1(E);
	printf("ϣ����Ƕ����������Ϊ:");
	for(i=0;i<n;i++){
		printf("%d ",E[i]);
	}
	printf("\n");
	
	int	F[] = {5,3,1,7,8,6,2,4,9};
	Shell_arrange_2(F);
	printf("ϣ����Ƕð��������Ϊ:");
	for(i=0;i<n;i++){
		printf("%d ",F[i]);
	}
	printf("\n");
	
	int	G[] = {5,3,1,7,8,6,2,4,9};
	Quick_sort(G,0,8);
	printf("����������Ϊ:");
	for(i=0;i<n;i++){
		printf("%d ",G[i]);
	}
	printf("\n");

	int	H[] = {5,3,1,7,8,6,2,4,9};
	Heap_Sort(H);
	printf("��������Ϊ:");
	for(i=0;i<n;i++){
		printf("%d ",H[i]);
	}
	printf("\n");
	
	int	I[] = {5,3,1,7,8,6,2,4,9};
	int I_1[9];
	MSORT(I,I_1);
	printf("��·�鲢������Ϊ:");
	for(i=0;i<n;i++){
		printf("%d ",I[i]);
	}
	printf("\n");
	
	int	J[] = {5,3,1,7,8,6,2,4,9};
	int J_1[9];
	Base_Sort(J,J_1);
	printf("����������Ϊ:");
	for(i=0;i<n;i++){
		printf("%d ",J_1[i]);
	}
	printf("\n");
	
	int K[] = {1,2,3,4,5,6,7,8,9};
	Linear_Search(K,8);
	Linear_Search(K,9); 
	Bin_Search(K,9);
} 
void Select(int A[]){
	int i,j;
	int Pos,temp;
	for(i=0;i<n;i++){
		Pos = i;
		for(j=i+1;j<n;j++){
			if(A[j]<A[Pos]) Pos = j; 
		}
		if(Pos!=i){
			temp = A[i];
			A[i] = A[Pos];
			A[Pos] = temp; 
		}
	}
}
void Bubble(int A[]){
	int i,j;
	int flag,temp;
	for(i=n-1;i>=0;i--){
		flag = 0;
		for(j=0;j<i;j++){
			if(A[j]>A[j+1]){
				flag = 1;
				temp = A[j];
				A[j] = A[j+1];
				A[j+1] = temp;
			}
		}
		if(flag == 0){
			break;
		}
	}
}
void Linear_Insert(int A[]){
	int i,j;
	int temp;
	for(i=0;i<n-1;i++){//tip
		temp = A[i+1];
		j = i;
		while((j>=0)&&(temp<A[j])){
			A[j+1] = A[j];
			j--;
		}
		A[j+1] = temp;
	}
} 
void Bin_Sort(int A[]){
	int i,j;
	int m,x,low,high;
	for(i=1;i<n;i++){
		x = A[i];
		low = 0; high = i-1;
		while(low<=high){
			m = (low + high) / 2;
			if(x<A[m]){
				high = m-1;
			}else{
				low = m+1;
			}
		}
		for(j=i-1;j>=low;j--){
			A[j+1] = A[j];
		} 
		A[low] = x;
	}
}
void Shell_arrange_1(int A[]){
	int i,j;
	int d,temp;
	d = n;
	while(d>1){
		d = d/2;
		for(i=0;i<n-d;i++){
			temp = A[i+d];
			j = i;
			while(j>=0 && temp<A[j]){
				A[j+d] = A[j];
				j = j - d;
			}
			A[j+d] = temp;
		}
	}
} 
void Shell_arrange_2(int A[]){
	int i,j;
	int temp;
	int d = n;
	int flag;
	while(d>1){
		flag = 1;
		d = d/2;
		while(flag == 1){
			flag = 0;
			for(i=0;i<n-d;i++){
				j = i+d;
				if(A[i]>A[j]){
					temp = A[i];
					A[i] = A[j];
					A[j] = temp;
					flag = 1;
				}
			}
		}
		
	}
}
void Quick_sort(int A[],int low,int high){
	int i,j;
	int temp;
	if(low<high){
		i = low; j = high; temp = A[i];
		while(i<j){
			while(i<j && temp>=A[j]){
				j--;
			}
			if(i<j){
				A[i] = A[j];
				i++; 
			}
			while(i<j && temp<A[i]){
				i++;
			}
			if(i<j){
				A[j] = A[i];
				j--;
			}
		}
		A[i] = temp;
		Quick_sort(A,low,i-1);
		Quick_sort(A,i+1,high);	
	}
} 
void Heap_Adjust(int A[],int i,int m){
	int j,temp;
	temp = A[i];j = 2*i+1;
	while(j<=m-1){
		if(j<=m-2 && A[j]<A[j+1]) j=j+1;
		if(temp>=A[j]){
			A[(j-1)/2] = temp;
			return;
		}
		A[(j-1)/2] = A[j];
		j = 2*j+1;
	}
	A[(j-1)/2] = temp; 
}
void Heap_Sort(int A[]){
	int i,temp;
	for(i=n/2-1;i>=0;i--){
		Heap_Adjust(A,i,n);
	}
	/*for(i=0;i<n;i++){
		printf("%d ",A[i]);
	}printf("\n");*/
	for(i=n-2;i>=0;i--){
		temp = A[i+1];
		A[i+1] = A[0];
		A[0] = temp;
		Heap_Adjust(A,0,i+1);
	}
}
void Merge(int A[],int s,int t,int u,int Z[]){
	int i,j,k;
	i = s; j = t+1; k = s;
	while(i<=t && j<=u){
		if(A[i]<=A[j]){
			Z[k++] = A[i++];
		}else{
			Z[k++] = A[j++];
		}
	}
	while(i<=t){
		Z[k++] = A[i++];
	}
	while(j<=u){
		Z[k++] = A[j++]; 
	}
}
void MPASS(int A[],int B[],int m,int t){
	int i = 0;
	int j;
	while((m-i)>=2*t){
		Merge(A,i,i+t-1,i+2*t-1,B);
		i = i+2*t;
	}
	if((m-i)>t){
		Merge(A,i,i+t-1,m-1,B);
	}else{
		for(j=i;j<m;j++){
			B[j] = A[j];
		}
	}
}
void MSORT(int A[],int B[]){
	int t = 1;
	while(t<n){
		MPASS(A,B,n,t);
		t = 2*t;
		if(t<=n){
			MPASS(B,A,n,t);//�� 
		t = 2*t; 
		}
	}
}
void Base_Sort(int A[],int B[]){
	int Count[n];
	int i,j;
	for(i=0;i<n;i++){
		Count[i] = 0;
	}
	for(i=0;i<n-1;i++){
		for(j=i+1;j<n;j++){
			if(A[i]>A[j]){
				Count[i]++;
			}
			else{
				Count[j]++;
			}
		}
	}
	for(i=0;i<n;i++){
		B[Count[i]] = A[i];
	}
} 
void Linear_Search(int A[],int K){
	int i ;
	int flag = 0;
	int position;
	for(i=0;i<n;i++){
		if(A[i] == K){
			flag = 1;
			position = i;
		}
	}
	if(flag == 1){
		printf("���ҳɹ�,Ϊ��%d��Ԫ��\n",position+1); 
	}else{
		printf("����ʧ��\n");
	}
}
void Bin_Search(int A[],int K){
	int i,low,high,m;
	int flag = 0;
	low = 0;high = n-1;
	while(low<=high){
		m = (low+high)/2;
		if(K<A[m]){
			high = m-1;
		}
		else if(K>A[m]){
			low = m+1;
		}
		else{
			flag = 1;
			i = m;
			break;
		}
	}
	if(flag == 1){
		printf("���ҳɹ�,�ڵ�%dλ�ô�\n",i+1);
	}
	else{
		printf("����ʧ��\n");
	}
}
