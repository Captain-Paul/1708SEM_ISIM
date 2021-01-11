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