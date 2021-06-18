use MyDB
if exists(select * from sysobjects where name = 'PersonInformation')
	drop table PersonInformation
if exists(select * from sysobjects where name = 'EventInformation')	
	 drop table EventInformation
go
/*=================������======================*/
create table EventInformation
(
/*	
	�ڴ�����ʱ���Լ����2�ַ�ʽ��1��ʹ��constraint 2ʹ��constraint
	����(����) ����(����) ��ʶ(���ӣ�����) �Ƿ�����Ϊ�գ�Ĭ��Ϊnull��
	��ʹ��constraintʱ,��������������λ�ù̶�������˳����Դ���,�����Ը�Լ���Զ���ȡ��
	ʹ��constraintʱ,primary key,foreign key,check,unique,default���Ը�Լ���Զ���ȡ��
*/
	EventID int identity(10001,1), --primary key�ڴ��������޷�����Լ����
	EventName nvarchar(255) not null unique, 
	EventDate date,
	EventGrade int not null check(EventGrade=1 or EventGrade=2 or EventGrade = 3), --�¼��ȼ���1-3��
	EventPay money not null default 0, --Ĭ��Ϊ0
	EventMark varchar(255),
	--ʹ��constraintʱ�������Լ��ȡ�������Զ����ͬԼ��ͬʱ����һ��Լ����
	CONSTRAINT PK_EventID PRIMARY KEY (EventID),--�������ø�������
	--Ҳ����ÿ��Լ���������ȡ��
	--constraint UQ_EventName unique (EventName),
	constraint UQ_EventMark unique (EventMark)
)
create table PersonInformation --������UserInfo
(
	PersonID int identity(1,1) constraint PK_PersonID primary key, --
	PersonName nvarchar(50) not null, 
	Age int not null check(Age>=1 and Age<=200), --1-200
	Gender int not null check(Gender=1 or Gender=0), --0����Ů�ԣ�1�������ԣ�Ĭ��1
	Hobby nvarchar(255),
	PersonAdress nvarchar(255) constraint DF_PersonAdress default '�������',--��������
	EventID int not null foreign key(EventID) references EventInformation(EventID),--�������������������������
	BriefIntroduction ntext
	--,constraint DF_PersonAdress default('�������') for PersonAdress --������
	,constraint FK_EventID foreign key(EventID) references EventInformation(EventID)
	--,constraint CK_Age check((Age>=1 and Age<=200))
)

	
/*
insert into EventInformation(EventName,EventDate,EventGrade,EventPay)
values('ѧϰ���','2016',3,20000)

insert into PersonInformation(PersonName,Age,Gender,Hobby,PersonAdress,EventID,BriefIntroduction)
values('Ҷ��','23',1,'LOL�����','����',10001,'������������')
*/

select * from EventInformation
select * from PersonInformation
