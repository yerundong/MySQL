use MyDB
go
if exists( select * from sysobjects where name = 'BuyersList' )
drop table BuyersList;
if exists( select * from sysobjects where name = 'BuyersList2' )
drop table BuyersList2;
if exists( select * from sysobjects where name = 'BuyersList3' )
drop table BuyersList3;
if exists( select * from sysobjects where name = 'CommodityList' )
drop table CommodityList;
/*=======================��Ʒ�б�===================*/
create table CommodityList
(
	CommodityID bigint identity(1001,1) constraint PK_commodityID primary key,
	CommodityName nvarchar(200) not null constraint UQ_commodityName unique,
	CommodityPrice bigint not null,
	CommodityMaterial nvarchar(255) 
)
go
/*==================����б�======================*/
create table BuyersList
(
	BuyerID bigint identity(10001,1) constraint PK_BuyerID primary key,
	BuyerName nvarchar(200) not null constraint UQ_BuyerName unique,
	CommodityID bigint not null constraint FK_CommodityID foreign key(CommodityID) references CommodityList(CommodityID),
	Score tinyint constraint DF_Score default (5) constraint CK_Score CHECK (Score<=5 AND Score>=1) 
)
go
/*===============���뵥������=====================*/
--��������ݱ������[Լ������]
--[һ]����������:����[��ʶ��]��������,������������ݱ��밴��˳����д,����ȱ©(��ʹ��Ĭ��ֵҲ��Ҫ��)
insert into CommodityList 
values('�������',799,'') 

insert into BuyersList 
values('����',1001,default) --Score��Ĭ��ֵ,��������дdefault����Ч

--[��]�����ض���
insert into CommodityList(CommodityName,CommodityPrice) 
values('ţ�п�',1000)

insert into BuyersList(BuyerName,CommodityID) 
values('����',1002) --����ֵĬ����Ч

/*===============���뵥�л��������=====================*/
--[һ]����������
insert into CommodityList
select '�˶�Ь',250,'��' union
select '����ñ',300,'' union
select '��ȷ��',552,'��ȷ��'

insert into BuyersList
select 'ŷ����˿',1003,1 union
select '�Ϲٳճ�',1004,3 union
select '����ɧ��',1005,2

--[��]�����ض���
insert into CommodityList(CommodityName,CommodityPrice)
select '����',2000 union
select 'ȹ��',1555 union
select '����',552

insert into BuyersList(BuyerName,CommodityID)
select '��5',1006 union
select '��Ƥ',1007 union
select '���',1008
go

/*===============����֮������ݵ���=====================*/
--[��һ�ַ�ʽ]
--����[�Ѵ���]�ı�֮������ݵ���,����ִ�ж��
--Ҫ��:���ű��еĸ���,˳�����һһ��Ӧ,����[�����Ƶ�����]���������[������]��[Լ������]
--ֻ��������,������Լ������
create table BuyersList2 --�½�һ�ű�
(
	BuyerID2 bigint identity(10001,1) constraint PK_BuyerID2 primary key,
	BuyerName2 nvarchar(200) not null,
	CommodityID2 bigint not null,
	Score2 tinyint,
	BuyDate date null  --�����Ҳû��ϵ
)
insert into BuyersList2(BuyerName2,CommodityID2,Score2) --����[����]Ҳ����[�ض�],����Ͳ�д[����]��д������
select BuyerName,CommodityID,Score
from BuyersList
go
--[�ڶ��ַ�ʽ]
--��[�½�]��,ԭ�Ȳ����ڵı���[��һ���Ѵ��ڱ�]������,ֻ��ִ��һ��
--ֻ��������,������Լ������
select BuyerName,CommodityID,Score
into BuyersList3
from BuyersList
go

select * from BuyersList
select * from BuyersList2
select * from BuyersList3
select * from CommodityList
