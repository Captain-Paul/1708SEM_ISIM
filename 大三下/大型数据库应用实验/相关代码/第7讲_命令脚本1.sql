-- 7.1 ��������

-- 1�����Ӵ����������
alter table stock add s_profile text
alter table stock add s_photo image
alter table stock add s_photo_type nchar(10)
go

-- 2����������
sp_configure 'show advanced options',1
go
sp_configure 'Ad Hoc Distributed Queries',1
go
sp_tableoption N'dbo.stock', 'text in row', 'off'
go
reconfigure
go

-- 3��ʹ�� SELECT��UPDATE �� INSERT ���ô����������
select * from stock   where ���� = 'good stock'
go
delete from stock   where ���� = 'good stock'
go
select * from stock   where ���� like  '%good%'
go

--4��ʹ�� OPENROWSET ������д��������
Insert Into stock (����, ����, ����, s_photo)
select 'ss99991' as ����, 'zzzz' as ����, *
    from OPENROWSET(BULK 'E:\buaa\A3_DataAndCode\ss99991.txt', SINGLE_CLOB) as ����, 
         OPENROWSET(BULK 'E:\buaa\A3_DataAndCode\ss99991.jpg', SINGLE_BLOB) as s_photo
                   
select ����, ����, ����, s_photo from stock where ���� like 'ss%'
go
/*
--4������С��ģ����
select * from stock where s_id like 'ss%'  and s_profile is not null
select * from stock where s_id like 'ss%'  and s_profile is null

select * from stock where s_id like 'ss%'  and s_profile like '%�ٽ�%'
update stock set s_desc = 'aqwszx' where s_id ='ss001'

select * from stock where s_id like 'ss%'  and s_desc = 'aqwszx'     --����
select * from stock where s_id like 'ss%'  and s_desc like 'aqwszx%'
*/

--5��ʹ�� WriteText ����, д���ı�����
DECLARE @ptr_val binary(16)
SELECT @ptr_val = TextPtr(����) From stock Where ���� = 'ss99991'
WriteText  stock.����  @ptr_val 
'2019��4�¸��º�__ά��Լ���Ǽ�����Ӿ�������ѧϰ��ģʽʶ��������һ����Ҫ�о����⣮����ת����ά��Լ���һ����Ҫ������
������ά���ݰ�һ��Ҫ��ת������Ե�ά�ռ��У�ʹ�������ڵ�ά�ռ�����ʹ�����еķ����������'
select ����, ����, ���� from stock where ���� like 'ss%'
go

--6��ʹ��UpdateText�������ֲ������ı�
DECLARE @ptr_val  binary(16)
SELECT @ptr_val = TEXTPTR(����)  From stock  Where ���� = 'ss99991'
UpdateText stock.���� @ptr_val 0 3 '��ν��'		   --������ntext����
SELECT *  From stock  Where ���� = 'ss99991'
go

--7�������ı�����
DECLARE @ptr_val binary(16)
SELECT @ptr_val = TEXTPTR(����)  From stock  Where ���� = 'ss99991'
READTEXT stock.���� @ptr_val 4 6									

SELECT ����, SUBSTRING(����, 3, 6) AS ���� From stock  Where ���� = 'ss99991'

SELECT * From stock  Where ���� = 'ss99991'
go