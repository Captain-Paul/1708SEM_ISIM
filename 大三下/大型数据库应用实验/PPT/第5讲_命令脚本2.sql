--��5�� �ű�2
-- 5.3 �Զ��庯��  UDFs
--1����������
create function stock_code (@stock_name char(20))
returns varchar(10)
as 
begin
      declare @stock_code varchar(10)
      select @stock_code = ����  from stock_JY 
			    where  ���� = @stock_name 
      return @stock_code 
end
go
select * from stock_JY where ���� = dbo.stock_code('���ֽҵ')
go

declare @s_code1 varchar(10), @s_code2 varchar(10)
Set  @s_code1 = dbo.stock_code('���ֽҵ')
set  @s_code2 = dbo.stock_code('��������')
select '���ֽҵ'   ��Ʊ����, @s_code1  ��Ʊ����
select '��������'  ��Ʊ����, @s_code2   ��Ʊ����
go

--2��������ֵ����
create function TabDmess(@stock_name varchar(50))
returns table 
as 
return (select ����, ����, ���¼� from stock_JY            
         where ���� like '%' + @stock_name+'%')
Go
select * from TabDmess('����')
go

-- 3��������ֵ����
create function StockCJ(@Lmt_P money)
returns @StockMess table (s_id char(6),
                          s_name char(20),
                          s_price money,
                          qty int)
as
begin
   insert into @StockMess
      select stock_JY.����, ����, ���¼�, �ɽ���
        from stock_JY 
       where ���¼� > @Lmt_P
	insert into @StockMess values ('000111', 'My Stock', '155.55', '1000')
   return
end
go
select * from StockCJ(100)
go

-- 5.4  �Զ��庯��Ӧ��
-- ��1����ȡ�����ַ���
create function fun_getCN(@str nvarchar(1000))
returns nvarchar(1000)    
as   
begin   
     declare @word nchar(1), @CN nvarchar(1000)     --@str�洢ԭʼ�ַ���
     set  @CN = ''   
     while len(@str) > 0    
     begin   
         set @word = left(@str,1)    
         if unicode(@word) between 19968 and  19968 + 20901  
              set  @CN = @CN + @word                  --@CN�洢���ص������ַ���
         set  @str = right(@str, len(@str) - 1)    
     end   
     return  @CN
end   
go
select dbo.fun_getCN('ASKG��as̳KDL'),  dbo.fun_getCN('ASDKGՓy��KDL'),
       dbo.fun_getCN('AS��DK��DL'), dbo.fun_getCN('ASKG����ll34�Ȱ�aKDL')
go

-- ��2����ȡ����
create function get_number(@s varchar(100))
returns varchar(100)
as
begin
      while patindex('%[^0-9]%', @S) > 0
            set @s=stuff(@S, patindex('%[^0-9]%', @s), 1, '')
       return  @S
end 
Go
select DBO.GET_NUMBER('��ϰA1B2C3ABC')
go

-- ��3�������ظ��ַ�
CREATE FUNCTION DBO.DISTINCT_STR2(@S varchar(8000)) 
 RETURNS VARCHAR(100)
 AS
 BEGIN
       IF @S  is NULL  Return NULL
       Declare  @New  Varchar(50)
       While  Len(@S)>0
       BEGIN
            SET @New=ISNULL(@New, '') + LEFT(@S,1)
            SET @S=Replace(@S, LEFT(@S, 1), '')
       END
       RETURN @NEW
 END
 GO
SELECT DBO.DISTINCT_STR2('ABabdcCDfgrabcbABCacdf')
SELECT DBO.DISTINCT_STR2('ABabABab')
go

-- 5.4 �α�
create procedure S_PLevel @s_name varchar(20) As
Declare @s_id varchar(10), @price money, @cje money
Declare @AB_cje money, @CD_cje money, @E_cje money
Declare @AB_cnt int, @CD_cnt int, @E_cnt int
Declare @L_tb1 table (Lev_type varchar(20), s_id varchar(10), price money, cje money, Lev_desc varchar(50))
Declare @L_tb2 table (Lev_type varchar(20), stock_cnt int, stock_cje money)
Declare s_cur cursor for  Select ����, ���¼�,�ɽ��� from stock_JY where ���� like '%' + @s_name + '%'
select @AB_cje=0,  @CD_cje=0,  @E_cje=0
select @AB_cnt=0,  @CD_cnt=0,  @E_cnt=0
Open s_cur
Fetch s_cur into @s_id, @price, @cje
While (@@fetch_status = 0)
 Begin
      if (@price >= 50)
      begin
     	 insert into @L_tb1 (Lev_type, s_id, price, cje, Lev_desc)
     	     values ('AB', @s_id, @price,@cje, '�߼�λ')
         select @AB_cje = @AB_cje + @cje
		 select @AB_cnt = @AB_cnt + 1
      end  
      else if (@price  >= 20)
      begin
          insert into @L_tb1 (Lev_type, s_id, price, cje, Lev_desc)
	          values ('CD', @s_name, @price, @cje, '�м�λ')
          select @CD_cje = @CD_cje + @cje
		  select @CD_cnt = @CD_cnt + 1
      end
      else
      begin
          insert into @L_tb1 (Lev_type, s_id, price, cje, Lev_desc)
	       	  values ('E', @s_name, @price, @cje, '�ͼ�λ')
          select @E_cje = @E_cje + @cje
		  select @E_cnt = @E_cnt + 1
      end
      Fetch s_cur into @s_id, @price, @cje
end
Close s_cur
Deallocate s_cur
insert into @L_tb2 values ('AB', @AB_cnt, @AB_cje)
insert into @L_tb2 values ('CD', @CD_cnt, @CD_cje)
insert into @L_tb2 values ('E', @E_cnt, @E_cje)
select * from @L_tb1
select * from @L_tb2
return
go

exec S_PLevel '����'

-- 5.5 ����׼��
-- 1. ������
CREATE TABLE stock(
	���� varchar(10) NOT NULL PRIMARY KEY,
	���� varchar(20) NOT NULL,
	���� ntext NULL)
go
drop TABLE stock_YJY
go
CREATE TABLE stock_YJY(
	������ˮ int Identity(1,1) NOT NULL PRIMARY KEY,
	���� varchar(10) NOT NULL,
	���¼� money NULL,
	��߼� money NULL,
	��ͼ� money NULL,
	��ͼ۽��� money NULL,
	�ɽ��� int NULL,
	�ɽ��� money NULL,
	�������� date NULL)
go

-- 2����������
-- ��1�������Ʊ������Ϣ
insert into stock(����, ����) select ����, ���� FROM stock_JY

-- (2) �����Ʊ100�콻������
insert into stock_YJY (����, ���¼�,��߼�, ��ͼ�, �ɽ���, �ɽ���, ��������)
   select ����, ���¼�,���, ��ͼ�, �ɽ���, �ɽ���, '2020-01-01' from stock_JY order by ����
declare @ii int 
select @ii = 1
while (@ii<= 100)
begin
  insert into stock_YJY (����, ��ͼ�, �ɽ���, ��������)
     select ����, ��ͼ�*(0.5+rand()), �ɽ���*(0.5+rand()), 
	        DateAdd(day, @ii, '2020-01-01')
	   from stock_JY order by ����  
   set @ii = @ii + 1
end
update stock_YJY
  set  ��߼� = ��ͼ�*(1+rand()),  ��ͼ۽��� = ceiling(��ͼ�)
update stock_YJY
  set ���¼� = ��ͼ�+(��߼�-��ͼ�)*rand(),
      �ɽ��� = �ɽ���*(��߼�+��ͼ�)/2
go

--3���鿴����
select * from stock
select * from stock_YJY order by ����, ��������
