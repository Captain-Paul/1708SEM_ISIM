#include<stdio.h>
#include<stdlib.h>
#define M 128
#define n 10 
//������������� 
int A[n] = {5,3,8,2,4,7,9,1,10,6};
struct node{
	int data;
	struct node *Lchild;
	struct node *Rchild;
};
void PostOrder_TD(struct node *T);//������� �ݹ� 
void MidOrder_TD(struct node *T); //������� �ݹ� 
void PreOrder_TD(struct node *T);//ǰ����� �ݹ� 
void PreOrder_FD(struct node *T);//ǰ����� �ǵݹ� 
void MidOrder_FD(struct node *T); //������� �ǵݹ� 
void PostOrder_FD(struct node *T);//������� �ǵݹ� 
int Calculate_depth(struct node *T);//������� 
void Grade_through(struct node *T);// ��α��� 
void Swap_child(struct node *T); //�������ӽڵ� 
struct node *Find_node(struct node *T,int b);
struct node *p ,*q;
struct node *T = NULL; 


int main(){
	struct node *x;
	int i;
	for(i=0;i<n;i++){
		x = (struct node*)malloc(sizeof(struct node));
		x->Lchild = NULL;
		x->Rchild = NULL;
		x->data = A[i];
		if(T == NULL){
			T = x;
		}
		else{
			p = T;	
			while(p!=NULL){
				q = p;
				if(x->data < p->data) p = p->Lchild;
				else p = p->Rchild;
			}
				if(x->data < q->data) q->Lchild = x;
				else q->Rchild = x;
				
		
		}
	}
	printf("���������ݹ��㷨��");
	PostOrder_TD(T);
	printf("\n");
	printf("���������ݹ��㷨��");
	MidOrder_TD(T);
	printf("\n");
	printf("ǰ�������ݹ��㷨��");
	PreOrder_TD(T);
	printf("\n");
	
	printf("ǰ�������ǵݹ��㷨��");
	PreOrder_FD(T);
	printf("\n");
	printf("���������ǵݹ��㷨��");
	MidOrder_FD(T);
	printf("\n");
	printf("���������ǵݹ��㷨��");
	PostOrder_FD(T);
	printf("\n");
	
	printf("�������Ϊ��");
	printf("%d",Calculate_depth(T));
	printf("\n");
	
	printf("��α�����");
	Grade_through(T);
	printf("\n"); 
	
	//printf("�������Һ��Ӳ�α�����");
	//Swap_child(T);
	//Grade_through(T);
	//printf("\n");
	
	int b;
	printf("��������Ҫ���ҵĽ�㣺");
	scanf("%d",&b); 
	printf("����ĳ����㣺%d\n",Find_node(T,b)->data);
	
	 
} 
void PostOrder_TD(struct node *T){
	if(T!=NULL){
		PostOrder_TD(T->Lchild);
		PostOrder_TD(T->Rchild);
		printf("%d ",T->data);
	}
}
void MidOrder_TD(struct node *T){
	if(T!=NULL){
		MidOrder_TD(T->Lchild);
		printf("%d ",T->data);
		MidOrder_TD(T->Rchild);
	}
}
void PreOrder_TD(struct node *T){
	if(T!=NULL){
		printf("%d ",T->data);
		PreOrder_TD(T->Lchild);
		PreOrder_TD(T->Rchild);
	}
}
void PreOrder_FD(struct node *T){
	int Top = -1;
	struct node *Stack[32];
	struct node *P;
	P = T;
	while(P!=NULL || Top>-1){
		if(P!=NULL){
			printf("%d ",P->data);
			Top++;
			Stack[Top] = P;
			P = P->Lchild;
		}
		else{
			P = Stack[Top];
			Top--;
			P = P->Rchild;
		}
	} 
} 
void MidOrder_FD(struct node *T){
	int Top = -1;
	struct node *Stack[32];
	struct node *P;
	P = T;
	while(P!=NULL || Top>-1){
		if(P!=NULL){
			
			Top++;
			Stack[Top] = P;
			P = P->Lchild;
		}
		else{
			P = Stack[Top];
			printf("%d ",P->data);
			Top--;
			P = P->Rchild;
		}
	} 
}
void PostOrder_FD(struct node *T){
	int Top = -1;
	struct node *Stack[32];
	struct node *P;
	int B[32];
	P = T;
	while(P!=NULL || Top>-1){
		if(P!=NULL){
			Top++;
			Stack[Top] = P;
			B[Top] = 0;
			P = P->Lchild;
		}
		else{
			P = Stack[Top];
			Top--;
			if(B[Top+1] == 0){
				Top++;
				Stack[Top] = P;
				B[Top] = 1;
				P = P->Rchild;
			}
			else{
				printf("%d ",P->data);
				P = NULL;
			}
			
		}
	} 
}
int Calculate_depth(struct node *T){
	int Top = -1;
	struct node *Stack[M];
	struct node *P;
	P = T;
	int max = -1;
	while(Top>-1 || P!=NULL){
		if(P!=NULL){
			Top++;
			Stack[Top] = P;
			P = P->Lchild;
		}else{
			P = Stack[Top];
			Top--;
			P = P->Rchild;
		} 
		if(Top>max){
			max = Top;
		}
	}
	return max+1;
}
void Grade_through(struct node *T){
	struct node *Queue[M];
	struct node *P;
	int rear,front;
	if(T!=NULL){
		Queue[0] = T;
		front = -1;
		rear = 0;
		while(front < rear){
			front ++;
			P = Queue[front];
			printf("%d ",P->data);
			if(P->Lchild !=NULL){
				Queue[++rear] = P->Lchild;
			}
			if(P->Rchild !=NULL){
				Queue[++rear] = P->Rchild;
			}
		}
	}
} 
void Swap_child(struct node *T){
	struct node *P,*temp;
	struct node *Queue[M];
	int rear,front;
	P = T;
	if(T!=NULL){
		rear = 0;
		front = -1;
		Queue[0] = P;
		while(front<rear){
			P = Queue[++front];
			temp = P->Lchild;
			P->Lchild = P->Rchild;
			P->Rchild = temp;
			if(P->Lchild != NULL){
				Queue[++rear] = P->Lchild;
			} 
			if(P->Rchild != NULL){
				Queue[++rear] = P->Rchild;
			}
		}
	}
	
}
struct node *Find_node(struct node *T,int b){
	struct node *P;
	P = T;
	while(P!=NULL){
		if(P->data == b){
			break;
		}
		else if(P->data > b){
			P = P->Lchild;
		}
		else if(P->data < b){
			P = P->Rchild;
		}
	}
	return P;
	 
}
