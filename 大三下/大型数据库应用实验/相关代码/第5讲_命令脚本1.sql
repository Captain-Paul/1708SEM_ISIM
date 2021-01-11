-- 5.1 �洢����
-- 1��Ĭ��ֵ����
if object_id('SpStockById') is not null
drop proc SpStockById
go

create proc SpStockById
@Stock_id nvarchar(10) = null     -- ���ò�����Ĭ��ֵ
as
if  (@Stock_id is not null)              -- �жϲ����Ƿ�Ϊ��
    select * from stock_JY  where ���� = @Stock_id
else
    select * from stock_JY
go

exec SpStockByID	             --ʹ��Ĭ��ֵ
exec SpStockById '600356'     --ʹ�ò���
go

-- 2����Return�����Ĵ洢���� 
if object_id('query_qty') is not null
drop proc query_qty
go

create proc query_qty @s_id char(8)
as
declare @JY_qty int
select @JY_qty = Ceiling(�ɽ���) from stock_JY 
              where ���� = @s_id
return @JY_qty
go

declare @rtn_qty int
exec @rtn_qty = query_qty '600356'
print @rtn_qty
go
 
-- 3���ݹ����  
if object_id('UpFactorial') is not null
drop proc UpFactorial
go
Create proc UpFactorial
@Value_In int,  @Value_Out int OUTPUT    -- ���롢�������
as
declare @D_In int,  @D_Out int                    -- ���롢���ձ���
if @Value_In > 1
begin
    select @D_In = @Value_In - 1;  
    exec UpFactorial @D_In, @D_out OUTPUT          -- �ݹ����
    select @Value_Out = @Value_In * @D_Out
end
else
    select @Value_Out =1  
print cast(@Value_In as varchar) + 
         ' factorial is '+ cast(@Value_Out as varchar);
Return
GO

declare @WorkingOut int
exec UpFactorial 5, @WorkingOut OUTPUT
print @WorkingOut
 
-- 5.2 ��ʱ��ͱ����

-- 1��������ʱ��
if object_id('Test1') is not null
drop proc Test1
go
Create Procedure Test1
AS
Create table #t1 (TC1 int  PRIMARY KEY)
Insert into #t1 values (99)
Exec Test2
go

if object_id('Test2') is not null
drop proc Test2
go
Create Procedure Test2
AS
Insert into #t1 values (88)
Create table #t2 (TC2 int PRIMARY KEY)
Insert into #t2 values (11)
SELECT * from #t1
SELECT * from #t2
go

Create table #t3 (TC3 int PRIMARY KEY)
Insert into #t3 values (555)
Create table #t1 (TC1 int PRIMARY KEY)
Insert into #t1 values (444)
Exec Test1
Select * from #t1
Select * from #t3
Select * from #t2
go

drop table #t3
drop table #t1
go

-- 2��ȫ����ʱ��
if object_id('FindTemptable') is not null
drop proc FindTemptable
go
create proc FindTemptable   
@View_userID varchar(20),              --�������������Ա�˺�
@outResult int out                     --���������0û�е�¼��1�Ѿ���¼��
as   
declare @View_sql varchar(100)  
if object_id ('tempdb.dbo.##' + @View_userID) is null  
begin   
   set @View_sql = 'create table ##' + @View_userid + ' (userid char(20)) '  
   exec(@View_sql)
   set @View_sql = 'insert into ' + '##'+@View_userID + ' values (1)'  
   exec(@View_sql)   
   set @outResult =0
   print '���Ե�½'  
end   
else
begin   
    set @outResult =1  
    print '�Ѿ���½'
end
Return
go

declare @dl_state int
exec FindTemptable  'stu1', @dl_state output
print @dl_state
go
