-- ��4�� �ű��ļ�

-- 4.1 ���Ի���
-- Print���
Print 'Hello��'
print 55
declare @rr datetime
set @rr = '2020-03-11'
print @rr            
print @@version
select * FROM Stock_JY  where ���� >  '60050'
print '�Ҳ�ѯ����'+CAST(@@rowcount as varchar(5))+'����¼'
go


-- 4.2 ��������
-- ʮ���������;���
declare @rr binary
set @rr = 0x4A
print @rr            
print CAST(@rr as int)
go

-- date��money���;���
declare @rr1 date
set @rr1 = '2020/03/11'
print @rr1 

declare @rr2 decimal(6,4)
set @rr2 = 13.12
print @rr2

declare @rr1 money, @rr2 money
set @rr1 = 13.122323
set @rr2 = 13.128989
print @rr1
print @rr2
go

-- λ���;���
declare @rr1 bit
set @rr1 = 1
print @rr1
print CAST(@rr1 as int)

declare @rr2 int
set @rr2 = 0
print @rr2
print CAST(@rr2 as bit)
go

-- ʱ������;���
create table SF_rec (ts_field timestamp not null,
                     sno char(8) not null,
                     fee money) 
insert into SF_rec(sno, fee) values ('s001', 100)
insert into SF_rec(sno, fee) values ('s002', 200)
select * from SF_rec
go


-- ��������ת��

--Cast����
select '��Ʊ' + CAST(���� as char(10)) +
       '�ĳɽ���Ϊ��' + CAST(���¼� as varchar(20)) +
       'Ԫ' AS �ɽ���Ϣ  
  from stock_JY
go
  
--convert������ת����ʽ
select  CONVERT(VARCHAR(19),GETDATE()) as 'ȱʡ',    
        CONVERT(VARCHAR(10),GETDATE(),110) as '110',
        CONVERT(VARCHAR(11),GETDATE(),106) as '106',  
        CONVERT(VARCHAR(24),GETDATE(),113) as '113'
go
 
--�Զ�����ת�� 
declare @unitprice float, @unitsinstock int
select @unitprice = 12.234, @unitsinstock = 18
SELECT @unitprice * @unitsinstock AS je
go      

declare @unitprice float, @unitsinstock char(2)
select @unitprice = 12.234, @unitsinstock = '18'
SELECT @unitprice * @unitsinstock + 600 AS je
go 

declare @unitprice float, @unitsinstock datetime
select @unitprice = 12.234, @unitsinstock = '2019-03-30'
SELECT @unitprice * @unitsinstock AS je
go 


-- 4.3 �����������ͱ��ʽ

-- ȫ�ֱ���
select * FROM stock_JY  where name > '600500'
go
print '��������ţ�' + convert(varchar(20),@@ERROR)
go


select * FROM stock_JY  where ���� > '600500'
go
print '���Ӱ��������' + convert(varchar(20),@@ROWCOUNT)
go

-- ��ֵ
declare @tt1  varchar(20),  @tt2  varchar(20)
declare @price_L float, @price_C int
Select @price_C = 1
print '�������' + convert(varchar(10), @price_C)
set @tt1 = (select min(����) from stock_JY)
print '��С��Ʊ����' + @tt1
set @tt2 = (select max(����) from stock_JY)
print '����Ʊ����' + @tt2
select @price_L = min(��ͼ�)+3 from stock_JY 
print '��ͳɽ���' + convert(varchar(30), @price_L)
go

-- �����
select 24%5
declare @b1 bit, @b2 bit
select @b1 = 0, @b2 = 1
select @b1 & @b2 as ��,   @b1 | @b2 as ��,
       ~@b1 as ��,        @b1 ^ @b2 as ����
go
