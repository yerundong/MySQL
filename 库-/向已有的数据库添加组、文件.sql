use	MyDB --ָ��MyDB���ݿ�
alter database MyDB add filegroup FQ --��Ӹ��ļ���FQ����ʱΪ���飩������������ļ���
go
alter database MyDB add file
(
	name = 'MyDB_data_fq1',
	filename = "D:\���ݿ�\MyDB\MyDB_data_fq1.ldf",
	size = 10mb, 
	filegrowth = 0 
),
(
	name = 'MyDB_data_fq2',
	filename = "D:\���ݿ�\MyDB\MyDB_data_fq2.ldf",
	size = 10mb, 
	filegrowth = 0 
)to filegroup FQ --��ӵ�FQ�ļ��飨���δд��Ĭ����ӵ�primary�飩

alter database MyDB add file
(
	name = 'MyDB_data_ft2',
	filename = "D:\���ݿ�\MyDB\MyDB_data_ft2.ldf",
	size = 10mb, 
	filegrowth = 0 
)to filegroup FT
go
alter database MyDB modify filegroup FQ default --FQ���ļ�����ΪĬ����
