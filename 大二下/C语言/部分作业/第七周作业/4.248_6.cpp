#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#define trying 7
void Guess(); 
int main(){
	Guess();
	int c;
	while(true){
		printf("Would you like to play again(y/n)?\n");
		//getchar();
		rewind(stdin);
		scanf("%c",&c);
		if(c=='y'){
			Guess();
		}else if(c=='n'){
			printf("goodbye!"); 
			break;
		}else{
			printf("������y����n!\n");
			continue; 
		}
	}
	return 0; 
} 
void Guess(){
	printf("������һ��1-100֮�����������²��Ƕ���(ֻ��7�λ���):");
	srand(time(NULL));
	int i = 0;
	int real = rand()%100+1;
	int m;
	while(i<trying){
		scanf("%d",&m);
		if(m<real){
			printf("Wrong number,Try again(Your input is lower):");
		}
		else if(m>real){
			printf("Wrong number,Try again(Your input is bigger):");
		}
		else if(m==real){
			printf("Hooray,you have won!\n");
			break; 
		}
		i++;
	}
	if(i==trying){
		printf("Sorry,you lose\n");
		printf("The real number is %d\n",m);
	}
}
