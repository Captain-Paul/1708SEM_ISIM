-- 4.4 ���̿��ƴ���ʾ��
-- ��֧���: ʾ��1
Declare @JY_QTY int, @JY_Money int
If exists (select * from stock_JY where ���� = '600356')
Begin
       Select @JY_QTY = �ɽ���, @JY_Money = �ɽ��� from stock_JY  where  ���� = '600356'
	   Print '-----stock 600536 �ɽ���Ϣ-------'
       Print  '�ɽ���' + convert(varchar(20), @JY_QTY)
       Print  '�ɽ���' + convert(varchar(20), @JY_Money)
End
Else
       Print 'û�иù�Ʊ��'
go 

-- ��֧���: ʾ��2
INSERT stock_JY(����, ����) VALUES ('999999', '��������')
go
IF @@error <> 0 
      PRINT '�ҳ��ִ���'
ELSE 
      PRINT '�Ҳ����¼�ɹ�'
go
select * from stock_JY where ���� like '����%'
delete  FROM stock_JY where ���� = '��������'
go

-- case���
SELECT ����, ����, �ɽ���, ���¼�, ��λ =  CASE
    WHEN ���¼� IS NULL THEN '��Ϣȱʧ'
    WHEN ���¼� < 10  THEN '�ͼ�'
    WHEN ���¼� between 10 and  20  THEN '�м�'
    WHEN ���¼� > 20 THEN '�߼�'
  END
FROM stock_JY
go

-- ѭ���ṹ
-- ʾ��1������1+2+3+����+100�ĺ�
DECLARE  @ii  Int,  @sum  Int
SELECT  @ii=1,  @sum =0
WHILE  @ii<=100
    SELECT @sum=@sum+@ii,  @ii=@ii+1
PRINT  @sum
go

-- ʾ��2����1-100֮�䱻7������������
Declare @number smallint, @sum smallint
Set @number = 1
Set @sum = 0
While @number <= 100
Begin
   If @number % 7 = 0
   Begin
      Set @sum = @sum + @number
      Print @number
   End
   Set @number = @number + 1
End
Print '1��100֮���ܱ�7������������Ϊ'+str(@sum)
go

-- ������:
Begin try
       Select 8/2
       select 8/0
       print 'aa'
End try
Begin catch
       Select Error_number() as �����,  Error_severity() as ����ȼ�,
              Error_state() as ����״̬, Error_procedure() as �������,
              Error_line() as ������,    Error_message() as ������Ϣ
End catch
go

-- goto���
Declare @price float
select @price = ���¼� from stock_JY where ���� = '600356'                                             
If @price < 10
    Goto print1
Else
    Goto print2
print1:
    Print '�ͼ�' 
    Goto theEnd
print2:
    Print '�߼�' 
    Goto theEnd
theEnd:
    return
go

-- ��ͣ��� waitfor
Waitfor delay '00:00:05'
update stock_JY set ���¼� = 19.99 where ���� = '600356'
select * from stock_JY where ���� = '600356'
go
Waitfor time '15:26'
update stock_JY set ���¼� = 1.00 where ���� = '600738'
select * from stock_JY where ���� = '600738'
go


--4.5 T-SQL��������ʾ��

-- 1�����ں���
-- ���ر�ʾָ�����ڵ���ݡ��·ݡ����ڵ����� 
select year(getdate()) ���, month(getdate()) �·�, day(getdate()) ����  
select year(getdate()) +  month(getdate()) + day(getdate()) 
go

-- ����ָ�����ڵ�ָ�����ֵ����� 
select datepart(year,getdate()) ��, datepart(month,getdate()) ��, datepart(day,getdate()) �� , datepart(week,getdate()) ��
select datepart(hour,getdate()) ʱ, datepart(minute,getdate()) ��, datepart(second,getdate()) ��
select datepart(hour,getdate()) + datepart(minute,getdate()) + datepart(second,getdate()) 
go

select datepart(week, getdate()), datepart(week, getdate()) + datepart(week, getdate())
select datepart(weekday, getdate()), datepart(weekday, getdate()) + datepart(weekday, getdate())
go

-- ���ر�ʾָ�����ڵ���ݡ��·ݡ����ڵ��ַ������� 
declare @Yname char(4), @Mname char(2), @Dname char(2) 
select @Yname = datename(year,getdate()), @Mname = datename(Month, getdate()), @Dname = datename(day,getdate())
print @Yname + '��' + @Mname + '��' + @Dname + '��' 
go
declare @Hour_name varchar(10), @Minute_name  varchar(10), @Second_name varchar(10) 
select @Hour_name  = datename(hour,getdate()), @Minute_name = datename(minute, getdate()), @Second_name = datename(second,getdate())
print @Hour_name  + '��' + @Minute_name  + '��' + @Second_name+ '��' 
go
select datename(week, getdate()), datename(weekday, getdate())

-- �����������㣬���������Զ�������������
select dateadd(year,4,getdate()) ��4��,  dateadd(month,14,getdate()) ��14����, dateadd(day,300,getdate()) ��300�� 
go
select datediff(day,getdate(), dateadd(month,14,getdate()))    --�������� ��ȥ ǰ������
select datediff(week,getdate(), dateadd(month,12,getdate()))    
select datediff(hour, getdate(), dateadd(day,2,getdate()))    
select datediff(minute, getdate(), dateadd(day,2,getdate()))    
select datediff(second, getdate(), dateadd(day,2,getdate()))    

go

declare @dt1 date
set @dt1 = '1997-05-19'
SELECT datediff(year,@dt1, getdate())as ���� , datediff(day,@dt1, getdate())as ���� 
GO


-- ��ѧ����
-- ȡ����ֵ
select Ceiling(3.1415926) ����, Floor(3.1415926) ����, Round(3.1415926, 2) ��λС������ ,Round(3.1415926, 3) ��λС������
-- ����0��99֮����������
select cast( floor(rand()*100) as int)

-- ����1��100֮����������
Select cast(ceiling(rand() * 100) as int)

-- �ַ�������
select ascii('abc'), ascii('a'),  ascii('b')
select Ltrim(Rtrim(str(45))) + Rtrim(ltrim(str(12)))+ char(100)
select Str (3.1415926,10, 4)
select left('I am a student', 6)
select subString('I am a student', 6, 10)    
select charIndex('student', 'I am a student')    
select replace('I am a student��you are a student', 
                            'student',  'teacher')
go

-- ͳ�ƺ���
select AVG(���¼�) AS '��ֵ' , STDEV(���¼�) AS '��׼ƫ��' , VAR(���¼�) AS '����' ,
       MAX(���¼�) AS '���ֵ' , MIN(���¼�) AS '��Сֵ' , COUNT(���¼�) AS '����',
	   MAX(���¼�) - MIN(���¼�) AS '����ֵ' , STDEV(���¼�) / AVG(���¼�) AS '����ϵ��' 
from stock_JY 
