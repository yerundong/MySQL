use	MyDB --指向MyDB数据库
alter database MyDB add filegroup FQ --添加辅文件组FQ（此时为空组），不可添加主文件组
go
alter database MyDB add file
(
	name = 'MyDB_data_fq1',
	filename = "D:\数据库\MyDB\MyDB_data_fq1.ldf",
	size = 10mb, 
	filegrowth = 0 
),
(
	name = 'MyDB_data_fq2',
	filename = "D:\数据库\MyDB\MyDB_data_fq2.ldf",
	size = 10mb, 
	filegrowth = 0 
)to filegroup FQ --添加到FQ文件组（如果未写，默认添加到primary组）

alter database MyDB add file
(
	name = 'MyDB_data_ft2',
	filename = "D:\数据库\MyDB\MyDB_data_ft2.ldf",
	size = 10mb, 
	filegrowth = 0 
)to filegroup FT
go
alter database MyDB modify filegroup FQ default --FQ辅文件组设为默认组
