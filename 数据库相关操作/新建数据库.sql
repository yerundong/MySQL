/*====�����µ����ݿ⣬�������ļ��飬����������־�ļ�====*/
use master --ָ��master���ݿ�
if exists(select * from sysdatabases where name= 'MyDB') --�ж��Ƿ�����ݿ��Ѵ���
drop database MyDB --�Ѵ��������ɾ��
go --�������־
create database MyDB --������ΪMyDB�����ݿ⣬Ĭ�ϴ���primary���һ�����ļ����������ݿ���ͬ��MyDB������һ����־�ļ���MyDB_log��
on primary --�������ļ���primary(�̶���)�����ٴ���һ�����ļ�������Ϊ����
	--���ļ�1��Ϣ
(
	name = 'MyDB_data1', --���ļ��߼��ļ�����������߼��ļ����������ļ������һ����������ң�
	filename = "D:\���ݿ�\MyDB\MyDB_data1.mdf", --���ļ������ļ�������ַ�������
	size = 10mb, --���ļ���ʼ��С�����
	maxsize = 500mb, --���ļ����������ֵ��Ĭ��Ϊ�����ƣ���ѡ�
	filegrowth = 15% --���ļ������ʣ�Ĭ��Ϊ1mb����ѡ�
), --���ļ������
filegroup FG --�������ļ���FG�����Զ��壩�����ٴ���һ�����ļ�������Ϊ����
	--���ļ�1��Ϣ
(
	name = 'MyDB_data_fg1', --���ļ��߼��ļ���
	filename = "D:\���ݿ�\MyDB\MyDB_data_fg1.ldf",--���ļ������ļ�������ַ��
	size = 10mb, --���ļ���ʼ��С
	maxsize = 500mb, --���ļ����������ֵ����δ�������������������壩
	filegrowth = 0 --δ���������ʣ�����Ҳ�ɲ��������ļ����ֵmaxsize��
),
	--���ļ�2��Ϣ
(
	name = 'MyDB_data_fg2',
	filename = "D:\���ݿ�\MyDB\MyDB_data_fg2.ldf",
	size = 10mb, 
	filegrowth = 0
),
filegroup FT --�������ļ���FT�����Զ��壩�����ٴ���һ�����ļ�������Ϊ����
	--���ļ�3��Ϣ
(
	name = 'MyDB_data_ft1',
	filename = "D:\���ݿ�\MyDB\MyDB_data_ft1.ldf",
	size = 10mb, 
	filegrowth = 0
)

log on --��־�ļ�(��־�ļ��������κ��ļ���)
	--��־1��Ϣ
(
	name = "MyDB_log1", --��־�ļ��߼��ļ���
	filename = "D:\���ݿ�\log\MyDB_log1.ldf",--��־�ļ������ļ�������ַ��
	size = 5mb, --��־�ļ���ʼ��С
	filegrowth = 0 --��־�ļ�������
),
	--��־2��Ϣ
(
	name = "MyDB_log2",
	filename = "D:\���ݿ�\log\MyDB_log2.ldf",
	size = 5mb,
	filegrowth = 0 
)	
go

select * from sysdatabases --��master���е�ϵͳ��sysdatabases�п��Բ鵽�Ѵ��������ݿ�MyDB����Ϣ