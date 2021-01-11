-- 7.3 XML���ݷ���
-- һ��XML ��������
-- 1�����������XML���ݵ����ݱ�
Create Table S_inf (
           s_id char(5) not null primary key,
           xml_name  char(20) null,
           xml_content xml null )
go

-- 2������XML���͵ı�������ֵ
declare @doc xml
select @doc = N'<note>
                   <to> wang </to>
				   <from age = "20"> zhang </from>
				   <heading> Reminder </heading>
				   <body> Do not forget me this weekend! </body>
				   <number> 12 </number>
			   </note>'
select @doc 
go

-- ����XML ����д��
-- 1�����ַ�����ʽ���S_inf ����һ������XML���ݵ�Ԫ��
INSERT INTO S_inf 
     VALUES('ss001', 'note.xml', '<note>
									<to>wang</to>
							 		<from age="20">zhang</from>
									<heading>Reminder</heading>
									<body>Do not forget me this weekend!</body>
							      </note>')
INSERT INTO S_inf 
     VALUES('ss002', 'stu.xml', '<school>
									<class>
						 				<student number="081101">
											<name>����</name>
											<sex>��</sex>
											<age>20</age>
										</student>
										<student number="6666666">
											<name>sdfgh����</name>
											<sex>Ů</sex>
											<age>21</age>
										</student>
									</class>
								</school>')
go

-- 2��ʹ�� OpenRowSet ������ XML �ļ����뵽���ݱ�
INSERT INTO S_inf(s_id, xml_name, xml_content)
 SELECT 'ss003', 'note' AS xml_name, * 
		FROM OpenRowSet(BULK N'E:\buaa\A3_DataAndCode\note.xml', SINGLE_CLOB)  AS note_content
go

-- ����XML��ѯ
-- 1��query()����
SELECT  s_id, xml_content.query('/note/body') from S_inf
SELECT  s_id, xml_content.query('/note') from S_inf
go

DECLARE @xmldoc xml
Select @xmldoc = xml_content from S_inf where s_id = 'ss003'
SELECT @xmldoc.query('/note') 
SELECT @xmldoc.query('/note/from') AS ��Ϣ 
SELECT @xmldoc.query('.') AS ��Ϣ
go

DECLARE @xmldoc xml
SET @xmldoc = 
'<school>
    <class>
      <student>
         <name>����</name>
         <gender>��</gender>
        <age>20</age>
      </student>
      <student>
         <name>����</name>
         <gender>Ů</gender>
         <age>21</age>
      </student>
    </class>
 </school>'
 select @xmldoc.query('/school/class/student/name')
go

-- 2��value()����
--��1��Ԫ��ֵ��ѯ
INSERT INTO S_inf 
VALUES('ss004', 'aaa.xml',
'<school>
    <class>
      <student>
         <name>����</name>
         <gender>��</gender>
        <age>20</age>
      </student>
      <student>
         <name>����</name>
         <gender>Ů</gender>
         <age>21</age>
      </student>
    </class>
    <class>
      <student>
         <name>����</name>
         <gender>Ů</gender>
        <age>18</age>
      </student>
    </class>
 </school>')
 go
  
select s_id,xml_name,xml_content.value('(/school/class)[1]', 'varchar(50)') 
from S_inf where s_id = 'SS004'

select s_id,xml_name,xml_content.value('(/school/class)[2]', 'varchar(50)') 
from S_inf where s_id = 'SS004'

select s_id,xml_name,xml_content.value('(/school/class/student)[3]', 'varchar(50)') as XMLֵ
from S_inf where s_id = 'SS004'

select s_id,xml_name,xml_content.value('.', 'varchar(50)') as XMLֵ
from S_inf  where s_id = 'SS004'
go

--��2��value()����������ֵ����
INSERT INTO S_inf VALUES ('ss005', 'zz.xml', 
N'<school>
	<class>
	   <student number="081101">
	  	   <name>����</name>
		   <sex>��</sex>
		   <age>20</age>
	   </student>
	   <student number="081102">
		  <name>����</name>
		  <sex>Ů</sex>
		  <age>21</age>
	   </student>
    </class>
	<class>
	   <student number="020101">
	  	  <name>����</name>
		  <sex>Ů</sex>
		  <age>18</age>
	   </student>
   </class>
</school>')
go

select s_id,xml_name,xml_content.value('(/school/class/student/@number)[1]','char(6)')
from S_inf where s_id = 'ss005'

select s_id,xml_name,xml_content.value('(/school/class/student/@number)[3]','char(6)')
from S_inf where s_id = 'ss005'
go

-- 3��exists ��ѯ
select s_id, xml_content, xml_content.exist('/school/class/student/name') Ԫ���ж�,       
       xml_content.exist('/school/class/student/@number') �����ж�
  from S_inf 
go              

-- �ġ�XML���ݸ��£�modify()����
-- 1����������

-- ��1�����뵥��Ԫ��
update S_inf
   set xml_content.modify
       ('insert <birthday> 1997-02-10 </birthday> after 
         (/school/class/student/age)[2]')
where s_id = 'ss005'
go

-- ��2������ͬ���ڵ㣬�������Ԫ��
update S_inf
   set xml_content.modify
       ('insert <class>
                   <student>
                       <name>����</name>
                       <age>20</age>
                       <gender>��</gender>
                   </student>
                </class> 
         before (/school/class)[1]')
where s_id = 'ss005'

SELECT * from S_inf where s_id = 'ss005'
go

-- ��3�������ӽڵ㣬�������Ԫ��
DECLARE @xmldoc xml
SET @xmldoc = '<school>
					<class>
						<student> <name>����</name>  <sex>��</sex> <age>20</age> </student>
						<student> <name>����</name>  <sex>��</sex> <age>18</age> </student>
					</class>
					<class>
						<student> <name>����</name> <sex>��</sex>  <age>20</age> </student>
					</class> 
				</school>'
SET @xmldoc.modify('insert <student>
								<name>��÷</name>
								<sex>Ů</sex> 
								<age>21</age> </student>
					as last into (/school/class)[2]')
SELECT @xmldoc ����ڵ������
go

-- 2��ɾ������
SELECT  s_id, xml_content.query('/school') from S_inf where s_id = 'ss005'
update S_inf
set xml_content.modify('delete (/school/class/student/gender)[1]')
where s_id = 'ss005'
   
DECLARE @xmldoc xml
SET @xmldoc= '<student><name>����</name><sex>��</sex> <age>20</age> </student>'
SET @xmldoc.modify('delete (/student/age)[1]')
select @xmldoc
go

-- 3����������
SELECT  s_id, xml_content.query('/school') from S_inf where s_id = 'ss005'
update S_inf
SET xml_content.modify('replace value of 
       (/school/class/student/name/text())[2] with "mmmmmmm"')
where s_id = 'ss005'

update S_inf
SET xml_content.modify('replace value of 
       (/school/class/student/@number)[2] with "6666666"')
where s_id = 'ss005'

DECLARE @xmldoc xml
SET @xmldoc= '<student>
                  <name number="081101">����</name>
                  <sex>��</sex>
                  <age>20</age>
              </student>'
SELECT @xmldoc AS ���½ڵ�ǰ����
SET @xmldoc.modify('replace value of (/student/name/@number)[1] with "091101" ')
SET @xmldoc.modify('replace value of (/student/name/text())[1] with "����"')
SELECT @xmldoc ���½ڵ������
go

-- �塢��ϵ���ݺ�XML����ת��
-- 1����ϵ���� �� XML����
-- ��1��FOR XML RAW

select ����, rtrim(����) as ���� from stock  where ���� like 'ss%'	
   FOR XML RAW

--�Զ���Ԫ������
select ����, rtrim(����) as ���� from stock  where ���� like 'ss%'	
  FOR XML RAW('��Ʊ')
go

--��2��FOR XML AUTO
-- FOR XML AUTO�������Զ�ģʽ
select ����, rtrim(����) as ���� from stock  where ���� like 'ss%'	
 FOR XML AUTO
 
-- FOR XML AUTO��˫���Զ�ģʽ
SELECT stock.����, rtrim(stock.����) as ����, ������ˮ, ��������, �ɽ��� from stock, stock_YJY  
where stock.���� = stock_YJY.���� and stock.���� < '000006' and ������ˮ < 8000
  order by stock.����, ��������
 FOR XML AUTO
  
--��3��FOR XML PATH
-- FOR XML PATH����Ӧ��
select ����, rtrim(����) as ���� from stock  where ���� like 'ss%'	FOR XML PATH

-- FOR XML PATH������Ԫ������
select ���� AS '@��Ʊ���', rtrim(����) as ���� from stock  where ���� like 'ss%'	FOR XML PATH

-- FOR XML PATH��������Ԫ��
SELECT stock.���� as '@��Ʊ���', ���� as '������Ϣ/��˾����', ���� as '������Ϣ/��˾����',
       ������ˮ as '���׼�¼/���ױ��', �������� as '���׼�¼/��������', �ɽ��� as '���׼�¼/�ɽ���'
   FROM stock, stock_YJY  
   where stock.���� = stock_YJY.���� and stock.���� < '000003' and ������ˮ < 4000
   order by stock.����, ��������
   FOR XML Path ('��Ʊ��Ϣ')
 go

-- 2��XML����ϵ����
--��1������xml�ĵ�
declare @mydoc xml
set @mydoc='<Person>
				<row FirstName="Gustavo" LastName="Achong" />
				<row FirstName="Catherine" MiddleName="R." LastName="Abel" />
			</Person>'
 
--��2�����XML�ĵ��ľ��
declare @docHandle int
exec sp_xml_preparedocument @docHandle OUTPUT, @mydoc

--��3��д��Table
SELECT * into GenXML FROM OPENXML(@docHandle,'/Person/row',1)   
    WITH (FirstName nvarchar(50),
          MiddleName nvarchar(50),
          LastName nvarchar(50))
go
select * from GenXML

--��ͬ����ʾ��
declare @mydoc xml
set @mydoc='
<Products>
  <Product Category="Book">
    <Name>Windows 2008</Name>
    <Vendor>Vendor1</Vendor>
  </Product>
  <Product Category="Book">
    <Name>SQL2008</Name>
    <Vendor>Vendor2</Vendor>
  </Product>
</Products>'

declare @docHandle int
Exec sp_xml_preparedocument @docHandle OUTPUT,@mydoc

SELECT * into GenXML21 FROM  OPENXML(@docHandle,'/Products/Product',1)
WITH (Category nvarchar(50),Name nvarchar(50),Vendor nvarchar(50))

SELECT * into GenXML22 FROM  OPENXML(@docHandle,'/Products/Product',2)
WITH (Category nvarchar(50),Name nvarchar(50),Vendor nvarchar(50))

SELECT * into GenXML23 FROM  OPENXML(@docHandle,'/Products/Product',3)
WITH (Category nvarchar(50),Name nvarchar(50),Vendor nvarchar(50))
go
select * from GenXML21
select * from GenXML22
select * from GenXML23
go

drop table GenXML
drop table GenXML21
drop table GenXML22
drop table GenXML23
go

