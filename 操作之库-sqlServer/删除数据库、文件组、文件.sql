use master --指向master数据库
if exists(select * from sysdatabases where name= 'MyDB')
drop database MyDB --从磁盘上进行删除