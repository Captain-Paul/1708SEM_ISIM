-- ��3���ű�  --���ݵ��뵼��

-- 1����������
EXEC sp_configure 'show advanced options', 1 
go
RECONFIGURE 
go
EXEC sp_configure 'xp_cmdshell', 1 
go
RECONFIGURE
go 

-- 2��BCP ���ݵ���

--��1�����ݵ���������������
EXEC master..xp_cmdshell 
'bcp T_demo2020.dbo.Stock_JY out E:\BUAA\stock_exchange_data.txt -T -c'

--��2�����ݵ��������˺�����
EXEC master..xp_cmdshell 
'bcp T_demo2020.dbo.Stock_JY out E:\BUAA\stock_exchange_data2.txt -c -Usa -Psa'

--��3�����ݵ���������ѯ����
EXEC master..xp_cmdshell 
'bcp "SELECT ����, ���� FROM T_demo2020.dbo.Stock_JY" queryout E:\BUAA\stock_exchange_data3.txt -T -c'

-- 3��BCP ���ݵ���
-- ��1��׼�����ݱ�
select * into Stock_JY2 from Stock_JY
go
delete from Stock_JY2
go
select * from Stock_JY2
go

-- ��2����������
EXEC master..xp_cmdshell 
'bcp T_demo2020.dbo.Stock_JY3 in E:\BUAA\stock_exchange_data.txt -c -T'
go
select * from Stock_JY2
go

-- 4��BCP ��ʽ�ļ�����
EXEC master..xp_cmdshell 
'BCP T_demo2020.dbo.Stock_JY format nul -f E:\BUAA\stock_exchange_fmt.xml -x -c -T' 
go

-- 5��BULK ���ݵ���
-- ��1��׼�����ݱ�
select * into Stock_JY3 from Stock_JY
go
delete from Stock_JY3
go
select * from Stock_JY3
go

--��2�����ݵ���
BUlk insert  T_demo2020.dbo.Stock_JY3 from 'E:\BUAA\stock_exchange_data.txt'
	with (formatfile = 'E:\BUAA\stock_exchange_fmt.xml')
go
select * from Stock_JY3
go

--��3������ѡȡ�ֶ� 
select ����,����,�ɽ��� into T_demo2020.dbo.Stock_JY4
    FROM OpenRowSet(BULK N'E:\BUAA\stock_exchange_data.txt',                   
    FORMATFILE=N'E:\BUAA\stock_exchange_fmt.xml') 
    AS new_table_name 
go
select * from Stock_JY4
go
