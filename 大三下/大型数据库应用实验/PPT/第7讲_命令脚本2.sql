-- 7.2 ȫ�ļ���
-- 1������ȫ������
sp_fulltext_database 'enable';
go
Reconfigure
go

-- 2��contains
-- ��1��������
select * from stock where ���� like 'ss%'
select * from stock where contains(����, '�����')
select * from stock where contains(����,'"�����" or "������"')
go

-- ��2��ͬԴ�ʼ���
update stock set s_profile = 'I am running  I ran yesterday' where ���� = '000006'        
update stock set s_profile = 'He runs everyday' where ���� = '000007'     
insert into stock(����,����, s_profile) values('ss99992', 'ssss', 'He will run to school tomorrow')

select * From stock where contains(s_profile, 'formsof(inflectional, run)')
go
 
-- ��3����Ȩ����
SELECT * from  ContainsTable(stock, ����,   
                'isabout ("����" weight(0.3), "�����" weight(0.6), "�о�" weight(0.1))', 2)    --ȡtop 2����
                             
SELECT t2.rank, t1.* 
  from stock as t1, ContainsTable(stock, ����,   
                    'isabout ("����" weight(0.3), "�����" weight(0.6), "�о�" weight(0.1))', 2)  as t2
 where t1.���� = t2.[KEY]
go

-- 3��ʹ��FREETEXT�Ĳ�ѯ�����������ͬԴ���������Ǿ�ȷ�����������ȷ
--��1��contains�Ĳ�ѯ����
SELECT * FROM stock where contains(s_profile, 'I am')      --����Ӧ���ǵ��ʡ����Ǿ���
go

--��2��FreeText��ѯ
SELECT * FROM stock WHERE FREETEXT(����, '�����������չ')   --�Ǿ�ȷ��ѯ
SELECT * FROM stock WHERE FREETEXT(s_profile, 'ran')				--ͬԴ�ʲ�ѯ
SELECT * FROM stock WHERE FREETEXT(s_profile, 'I ran')				--�Ǿ�ȷ���Ӳ�ѯ
go
         
-- 4��ʹ��FreeTextTable����
SELECT * FROM FreeTextTable(stock, s_profile, 'running yesterday', 2) 

SELECT t2.rank, t1.* 
  from stock as t1, 
       FREETEXTTABLE(stock, s_profile, 'running yesterday', 4) as t2
 where t1.���� = t2.[key]
 go

 --5��Image���ݼ���ʾ��
Insert Into stock (����, ����, s_photo_type, s_photo)
  select 'ss99993' as ����, 'mmmm' as ����, '.txt' as s_photo_type, * 
             from OPENROWSET(BULK 'E:\buaa\A3_DataAndCode\ss99993.txt', SINGLE_CLOB) as s_photo

SELECT convert(varchar(100), substring(s_photo, 0,40))
FROM  stock WHERE CONTAINS(s_photo, '����')
go

-- 6��ͣ�ôʱ�Ŀ��͹�
ALTER FULLTEXT INDEX ON stock SET stoplist OFF
SELECT * FROM stock WHERE contains(s_profile, 'He')
ALTER FULLTEXT INDEX ON stock SET stoplist System
SELECT * FROM stock WHERE contains(s_profile, 'He')
