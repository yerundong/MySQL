exec sp_detach_db @dbname = 'MyDB' --�������ݿ�MyDB
go
exec sp_attach_db @dbname = 'MyDB', --�������ݿ�MyDB
@filename1 = "D:\���ݿ�\MyDB\MyDB_data1.mdf"