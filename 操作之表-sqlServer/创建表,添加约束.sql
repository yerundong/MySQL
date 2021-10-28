use MyDB
if exists(select * from sysobjects where name = 'PersonInformation')
	drop table PersonInformation
if exists(select * from sysobjects where name = 'EventInformation')	
	 drop table EventInformation
go
/*=================创建表======================*/
create table EventInformation
(
/*	
	在创建表时添加约束有2种方式：1不使用constraint 2使用constraint
	列名(必填) 类型(必填) 标识(种子，增量) 是否允许为空（默认为null）
	不使用constraint时,列名，数据类型位置固定，其他顺序可以打乱,不可以给约束自定义取名
	使用constraint时,primary key,foreign key,check,unique,default可以给约束自定义取名
*/
	EventID int identity(10001,1), --primary key在此设主键无法定义约束名
	EventName nvarchar(255) not null unique, 
	EventDate date,
	EventGrade int not null check(EventGrade=1 or EventGrade=2 or EventGrade = 3), --事件等级，1-3级
	EventPay money not null default 0, --默认为0
	EventMark varchar(255),
	--使用constraint时，必须给约束取名，可以多个相同约束同时设置一个约束名
	CONSTRAINT PK_EventID PRIMARY KEY (EventID),--可以设置复合主键
	--也可以每个约束相继设置取名
	--constraint UQ_EventName unique (EventName),
	constraint UQ_EventMark unique (EventMark)
)
create table PersonInformation --创建表UserInfo
(
	PersonID int identity(1,1) constraint PK_PersonID primary key, --
	PersonName nvarchar(50) not null, 
	Age int not null check(Age>=1 and Age<=200), --1-200
	Gender int not null check(Gender=1 or Gender=0), --0代表女性，1代表男性，默认1
	Hobby nvarchar(255),
	PersonAdress nvarchar(255) constraint DF_PersonAdress default '马尔代夫',--不带括号
	EventID int not null foreign key(EventID) references EventInformation(EventID),--必须有先有主键，才能设外键
	BriefIntroduction ntext
	--,constraint DF_PersonAdress default('马尔代夫') for PersonAdress --报错？？
	,constraint FK_EventID foreign key(EventID) references EventInformation(EventID)
	--,constraint CK_Age check((Age>=1 and Age<=200))
)

	
/*
insert into EventInformation(EventName,EventDate,EventGrade,EventPay)
values('学习编程','2016',3,20000)

insert into PersonInformation(PersonName,Age,Gender,Hobby,PersonAdress,EventID,BriefIntroduction)
values('叶润东','23',1,'LOL，编程','杭州',10001,'嘻嘻嘻哈哈哈')
*/

select * from EventInformation
select * from PersonInformation
