#include<stdio.h>
int main(){
	float per,num,rate;
	printf("�����뵥��:");
	scanf("%f",&per);
	printf("����������:");
	scanf("%f",&num);
	printf("�������ۿ���:");
	scanf("%f",&rate);
	
	float sum,sum_after_discount,tax,payment;
	sum = per * num ;
	sum_after_discount = sum - sum*rate;
	tax = sum * 0.06;
	payment = sum + tax;
	printf("�ܼ۸�%f\n",sum);
	printf("�ۿۺ��ܼ۸�%f\n",sum_after_discount);
	printf("Ӧ��˰��%f\n",tax);
	printf("Ӧ�����%f\n",payment);
}
