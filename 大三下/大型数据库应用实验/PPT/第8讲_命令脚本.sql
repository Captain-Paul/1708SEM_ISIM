-- 8.2 数据加密

-- 表结构修改
alter table stock add card_number VarBinary(256)       --二进制类型
go
-- 1、通行短语加密
-- （1）插入短语加密数据
insert into stock(代码, 名称, card_number)
          values ('ss99994', 'k1', EncryptByPassPhrase('this is my password','12345678901234567890'))
update stock set card_number = EncryptByPassPhrase('this is my password','99999999999999999999') 
 where 代码 = 'ss99994'
go

-- （2）查看非解密和解密数据
select 代码, 名称, card_number from stock where 代码 like 'ss99%'
select 代码, 名称, convert(varchar(20), DecryptByPassPhrase('this is my password', card_number)) 
  from stock where 代码 like 'ss99%'  

-- （3）短语的大小写敏感
select 代码, 名称, convert(varchar(20), DecryptByPassPhrase('This is my password', card_number)) 
  from stock where 代码 like 'ss99%'  
go

-- 2、对称密钥加密
-- （1）创建对称密钥
create symmetric key MySCardKey with algorithm = AES_256  encryption by password = 'my123456' 
go
-- （2）查看对称密钥
select * from sys.symmetric_keys 
go

-- （3）使用对称密钥
open symmetric key MySCardKey decryption by password = 'my123456'

insert into stock(代码, 名称, card_number)
    values ('ss99995', 'ddcc', EncryptByKey(Key_Guid('MySCardKey'), '66666555558888844444'))

select 代码, 名称, convert(varchar(20), DecryptByKey(card_number)) as card_num
from Stock where 代码 like 'ss99%'
go

-- （4）关闭对称密钥
close symmetric key MySCardKey
go

-- 3、非对称密钥加密
--（1）创建非对称密钥
Create Asymmetric Key My_ACK
  with algorithm=RSA_2048 Encryption by PassWord = 'ACK123456'

-- （2）查看非对称密钥   
Select * from sys.asymmetric_keys
go

--（3）使用非对称密钥加密和解密
insert into stock(代码, 名称, card_number) 
  values ('ss99996', 'xxxx',    
            EncryptByAsymKey(ASYMKEY_ID('My_ACK'),'55555444443333322222'))  

select 代码, convert(varchar(20), DecryptByAsymKey(ASYMKEY_ID('My_ACK'), card_number, N'ACK123456'))
from Stock where 代码 like 'ss99%'
go
 
-- 4、证书加密
-- （1）使用密码保护的证书
-- 创建证书
CREATE CERTIFICATE MyCert1     
       encryption by password = 'cert123456'  
       with subject = 'EnryptData certificate'
go

-- 加密数据
insert into stock(代码, 名称, card_number) 
          values ('ss99997', 'rrrxxxx', EncryptByCert(Cert_ID('MyCert1'),'999991199999'))   
 
 -- 解密数据
 select 代码, 名称, convert(varchar(20), 
                         DecryptByCert(Cert_Id('MyCert1'),card_number, N'cert123456'))
                         from stock where 代码 like 'ss99%' 				 
go
      
-- （2）使用数据库主密钥保护证书
-- 创建、打开数据库主密钥
Create Master Key Encryption By Password = 'DMK1234567'
Open Master Key Decryption By PassWord = 'DMK1234567'
go

-- 使用数据库主密钥创建证书
CREATE CERTIFICATE MyCert2 with Subject = 'Test Certificate'    
go
 
-- 使用证书加密、解密    
insert into stock(代码, 名称, card_number) 
          values ('ss99998', 'rrrxxxx', EncryptByCert(Cert_ID('MyCert2'),'2233445555'))          
                         
select 代码, 名称, convert(varchar(20), DecryptByCert(Cert_Id('MyCert2'),card_number))
  from stock where 代码 like 'ss99%'                         
go

-- 关闭和删除数据库主密钥
close MASTER KEY
drop master key			--删除失败（还有证书受其保护）
go

-- 8.3 数据库备份与恢复
--1、创建备份设备
EXEC sp_addumpdevice  'disk',   'My_BKD2',  'E:\buaa\A2_DemoDB\My_BKD2.bak'

--2、数据库和日志备份
--(1)完整备份
BACKUP DATABASE [T_demo2020] TO My_BKD  
        WITH INIT,  NAME = N'demo-完整数据库备份'

--（2）差异备份
BACKUP DATABASE [T_demo2020] TO My_BKD 
            WITH  DIFFERENTIAL, NOINIT,  NAME = N'demo-差异数据库备份'

--（3）日志备份
BACKUP LOG [T_demo2020] TO  [My_BKD] 
			WITH NOINIT,  NAME = N'demo-事务日志备份'

-- (4)备份尾日志
BACKUP LOG [T_demo2020] TO  [My_BKD] 
          WITH  NO_TRUNCATE ,  NOINIT, 
          NAME = N'Teaching_demo-尾日志 备份', NORECOVERY	
GO

--3、数据库恢复
-- （1）数据库限制访问，尾日志备份
-- （2）完整备份恢复
RESTORE DATABASE [T_demo2020] FROM [My_BKD] WITH  RESTRICTED_USER,  FILE = 1,  NORECOVERY

-- （3）差异备份恢复
RESTORE DATABASE [T_demo2020] FROM  [My_BKD] WITH  RESTRICTED_USER,  FILE = 2,  NORECOVERY

-- （4）日志备份恢复
RESTORE LOG [T_demo2020] FROM  [My_BKD] WITH  RESTRICTED_USER,  FILE = 3,  NORECOVERY

--(4)尾日志备份恢复，然后数据库恢复多用户状态
RESTORE LOG [T_demo2020] FROM [My_BKD] WITH  RESTRICTED_USER,  FILE = 6, RECOVERY
GO

