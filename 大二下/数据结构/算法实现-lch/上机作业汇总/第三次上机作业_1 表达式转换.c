#include<stdio.h>
#include<stdlib.h>
int isp(char x);
int icp(char x);
int main(){
	char a[200];
	char s;
	int l = 0;
	char Stack[100];
	printf("��������׺���ʽ����#�Ž�β:\n");
	while(1){
		scanf("%c",&s);
		a[l] = s;
		if(a[l] == '#'){
		break;
	}
		l++; 
	}
	
	int i = 0;
	int top = 0;
	printf("���Ϊ��");
	while(a[i] != '#'){
		switch(a[i]){
			case '(':{
				top++;
				Stack[top] = a[i];
				break;
			}
			case ')':{
				while(top>=0 && Stack[top]!='('){
					printf("%c",Stack[top]);
					top--;
				}
				top--;
				break; 
			}
				
				
			case '+':{
				while(top>=0 && isp(Stack[top])>=icp(a[i])){
					printf("%c",Stack[top]);
					top--;
				}
				top++;
				Stack[top] = a[i];
				break;
			}
			case '-':{
				while(top>=0 && isp(Stack[top])>=icp(a[i])){
					printf("%c",Stack[top]);
					top--;
				}
				top++;
				Stack[top] = a[i];
				break;
			}

			case '*':{
				while(top>=0 && isp(Stack[top])>=icp(a[i])){
					printf("%c",Stack[top]);
					top--;
				}
				top++;
				Stack[top] = a[i];
				break;
			}
			case '/':{
				while(top>=0 && isp(Stack[top])>=icp(a[i])){
					printf("%c",Stack[top]);
					top--;
				}
				top++;
				Stack[top] = a[i];
				break;
			}
			case '%':{
				while(top>=0 && isp(Stack[top])>=icp(a[i])){
					printf("%c",Stack[top]);
					top--;
				}
				top++;
				Stack[top] = a[i];
				break;
			}
			case '^':{
				while(top>=0 && isp(Stack[top])>=icp(a[i])){
					printf("%c",Stack[top]);
					top--;
				}
				top++;
				Stack[top] = a[i];
				break;
			}
			default:printf("%c",a[i]);
		}
		i++;
	}
	while(top>=0){
		printf("%c",Stack[top]);
		top--;
	}
}
//ջ�����ȼ� 
int isp(char x){
	switch(x){
		case'+':return 1;
		case '-':return 1;
		case'*':return 2;
		case'/':return 2;
		case'%':return 2;
		case'^':return 3;
		case'(':return 0;
		default:return 0;
	} 
}

//ջ�����ȼ� 
int icp(char x){
	switch(x){
		case'+':return 1;
		case'-':return 1;
		case'*':return 2;
		case'/':return 2;
		case'%':return 2;
		case'^':return 4;
		case'(':return 5;
		default:return 0;
	}
} 
