-- 6.1 ��������
-- 1��ȫ������
select row_number() over(order by ���¼�) as row_num, ��������, ����,���¼� from stock_YJY

-- 2����������   
select row_number() over(partition by �������� order by ���¼�) as row_num, ��������, ����,���¼� from stock_YJY 	  
 
-- 3����������
select row_number() over(order by ��ͼ۽���) as row_num,
       rank() over(order by ��ͼ۽���) as rank_num,  
       dense_rank() over(order by ��ͼ۽���) as dense_rank_num,
       ��������, ����, ��ͼ۽��� from stock_YJY where ���� like '60%' and �������� = '2020-01-01'
   
-- 4��������������
select row_number() over(partition by �������� order by ��ͼ۽���) as row_num,
       rank() over(partition by �������� order by ��ͼ۽���) as rank_num,  
       dense_rank() over(partition by �������� order by ��ͼ۽���) as dense_rank_num,
       ��������, ����, ��ͼ۽��� 
  from stock_YJY
 where ���� like '6001%' and �������� between '2020-01-01' and  '2020-01-05' and ��ͼ۽��� between 10 and 20
 go
 
-- 6.2 top ��ѯ
-- 1��ѡ��top ����
declare @ii int
set @ii = 1
select top (@ii+3) *  from stock_YJY order by �ɽ��� desc
select top ((@ii-0.4)*0.001) percent  *  from stock_YJY order by �ɽ��� desc 
select top 0.001 percent  *  from stock_YJY order by �ɽ��� desc 

-- top ȷ��������
select top 3 *  from stock_YJY order by ��ͼ۽���
select top 3 *  from stock_YJY order by ��ͼ۽���, ������ˮ
select top 3 with ties  *  from stock_YJY order by ��ͼ۽���

-- 2��top ���޸�
select * into stock_YJY2 from stock_YJY 
go
set nocount on    --��ֹ���ء���T-SQL���Ӱ�����������Ϣ
declare @cnt int
while 1=1
begin
   select @cnt = count (*) from  stock_YJY2
   if @cnt = 0 
      break
   print 'ʣ��' + cast(@cnt as varchar(10)) + '����¼'
   delete top(10000) from stock_YJY2 
end
select COUNT(*) from stock_YJY2
set nocount off
go
drop table stock_YJY2
go

-- 3��������ȡtop����
-- ����1��top + �Ӳ�ѯ
-- Top 1��ÿ�������ߵ�һ����Ʊ
select * from stock_YJY t1 where ������ˮ =
        (select top 1 ������ˮ from stock_YJY t2 
                      where t2.�������� = t1.�������� order by �ɽ��� desc, ����)
 order by ��������

-- Top N��ÿ�������ߵ�N����Ʊ
select * from stock_YJY t1 where ������ˮ in
        (select top 3 ������ˮ from stock_YJY t2 
                      where t2.�������� = t1.�������� order by �ɽ��� desc, ����)
 order by ��������, �ɽ��� desc, ����
go

-- ����2��top N + Row_Number() + ��ʱ��
select row_number() over(partition by �������� order by �ɽ��� desc, ����) as row_num, * 
 into #tb_top from stock_YJY
select * from #tb_top Where row_num < 4
order by ��������, row_num
go
drop table  #tb_top
go

-- ����3��cross apply
-- cross apply + �Ӳ�ѯ
select t1.* from  stock_YJY  t1  cross apply
    (select  top(3)  *  from  stock_YJY  t2 where  t2.�������� = t1.�������� order  by �ɽ��� desc, ����) t3
    where t1.������ˮ = t3.������ˮ 
    order by t1.��������, t1.�ɽ��� desc, t1.����
go

-- cross apply + ��ֵ����
-- ��ֵ��������
create function GetTopJY(@JY_Date date, @nn int)
returns table
as
return select top (@nn) ������ˮ,����, �ɽ���, ��������  from stock_YJY  
        where �������� = @JY_date order by �ɽ��� desc
go
-- ��ֵ��������
select t1.������ˮ, t1.����, t1.�ɽ���, t1.��������
  from stock_YJY t1 cross apply GetTopJY(t1.��������, 3) t3
    where t1.������ˮ = t3.������ˮ 
     order by t1.��������, t1.�ɽ��� desc, t1.����
go
-- 6.3 ���ݷ�ҳ
--���ñ��ʽ CTE
with CTE_Test as  (select *  from stock_YJY where �������� = '2020-01-01')
select * from CTE_Test where ���� like '001%'     /* CTE ��Ч */
select * from CTE_Test where ���� like '001%'     /* CTE ʧЧ */

-- row_number+���ñ��ʽ����ϯ��ҳ
declare @PageSize int, @Page_Num int
select @PageSize=10, @Page_Num=4;
with SN_T as  (select ROW_NUMBER() over(order by ���¼�) row_num, *
                 from stock_YJY)
select * from SN_T where row_num between @PageSize * (@Page_Num-1) + 1 and  @PageSize * @Page_Num
GO

-- row_number+��ʱ����ҳ����
select ROW_NUMBER() over(order by ���¼�) row_num, *
  into #SN_T2 from stock_YJY
create unique clustered index idx_rn on #SN_T2(row_num)
declare @PageSize int, @Page_Num int;
select @PageSize=10, @Page_Num=8;
select * from #SN_T2 
 where row_num between @PageSize * (@Page_Num-1) + 1 and  @PageSize * @Page_Num
  order by row_num                    
go     

--6.4 ����ͳ����ۺ�
-- 1����ֵ����
-- �۲�������Ԫ���50% (count(*)+1)/2
select count(*) from stock_YJY where ������ˮ > 1
select top(50) percent * from stock_YJY where ������ˮ > 1 

-- ��ֵ����, ʹ�����Ӳ�ѯǶ���븳ֵ
declare @ZZ1 int, @ZZ2 int
set @ZZ1 = (select min(t1.�ɽ���) from (select top(50) percent * from stock_YJY order by �ɽ��� desc, ������ˮ asc) t1)
Set @ZZ2 = (select max(t2.�ɽ���) from (select top(50) percent * from stock_YJY order by �ɽ��� asc, ������ˮ desc) t2)
select (@ZZ1+@ZZ2)/2  
go

-- 2�����������봰�ں���
-- ������ϸ�����ͳ��
select ������ˮ, ����, ��������, 
       ���¼�, avg(���¼�) OVER(PARTITION BY ����) AS ����,
	   �ɽ���, sum(�ɽ���) OVER(PARTITION BY ����) AS �ۼƳɽ�
from stock_YJY
order by ����, ��������

-- �۸����ͳ��
select ������ˮ, ����, ��������, ���¼�, 
       avg(���¼�) OVER(PARTITION BY ����) AS ����, 
	   ���¼� - avg(���¼�) OVER(PARTITION BY ����) AS diff,
	   100 * ���¼� / avg(���¼�) OVER(PARTITION BY ����) AS pct
from stock_YJY
order by ����, ��������
   
-- 3�����ݾۺ�ͳ��
-- �ۼƾۺϣ����ڿ��
select ������ˮ, ����, ��������, �ɽ���,
       sum(�ɽ���) over(partition by ���� order by ��������
	                    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) �ۼ�����
  from stock_YJY order by ����,�������� 
   
-- �����ۺϣ�7��ɽ���������ֵ
select ������ˮ, ����, ��������, �ɽ���,
       avg(�ɽ���) over(partition by ���� order by ��������
	                    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as '7�컬����ֵ'
  from stock_YJY order by ����,�������� 
go