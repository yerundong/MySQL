exec sp_detach_db @dbname = 'MyDB' --分离数据库MyDB
go
exec sp_attach_db @dbname = 'MyDB', --附加数据库MyDB
@filename1 = "D:\数据库\MyDB\MyDB_data1.mdf"