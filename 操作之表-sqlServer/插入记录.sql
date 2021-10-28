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
/*=======================商品列表===================*/
create table CommodityList
(
	CommodityID bigint identity(1001,1) constraint PK_commodityID primary key,
	CommodityName nvarchar(200) not null constraint UQ_commodityName unique,
	CommodityPrice bigint not null,
	CommodityMaterial nvarchar(255) 
)
go
/*==================买家列表======================*/
create table BuyersList
(
	BuyerID bigint identity(10001,1) constraint PK_BuyerID primary key,
	BuyerName nvarchar(200) not null constraint UQ_BuyerName unique,
	CommodityID bigint not null constraint FK_CommodityID foreign key(CommodityID) references CommodityList(CommodityID),
	Score tinyint constraint DF_Score default (5) constraint CK_Score CHECK (Score<=5 AND Score>=1) 
)
go
/*===============插入单行数据=====================*/
--插入的数据必须符合[约束条件]
--[一]插入所有列:除了[标识列]不能填外,其他插入的数据必须按照顺序填写,不可缺漏(即使有默认值也需要填)
insert into CommodityList 
values('花格衬衫',799,'') 

insert into BuyersList 
values('张三',1001,default) --Score有默认值,但必须填写default才起效

--[二]插入特定列
insert into CommodityList(CommodityName,CommodityPrice) 
values('牛仔裤',1000)

insert into BuyersList(BuyerName,CommodityID) 
values('李四',1002) --不设值默认起效

/*===============插入单行或多行数据=====================*/
--[一]插入所有列
insert into CommodityList
select '运动鞋',250,'橡胶' union
select '棒球帽',300,'' union
select '的确良',552,'的确良'

insert into BuyersList
select '欧阳拉丝',1003,1 union
select '上官痴痴',1004,3 union
select '东方骚货',1005,2

--[二]插入特定列
insert into CommodityList(CommodityName,CommodityPrice)
select '大衣',2000 union
select '裙子',1555 union
select '雨衣',552

insert into BuyersList(BuyerName,CommodityID)
select '赵5',1006 union
select '陈皮',1007 union
select '李狗蛋',1008
go

/*===============两表之间的数据导入=====================*/
--[第一种方式]
--两张[已存在]的表之间的数据导入,可以执行多次
--要求:两张表列的个数,顺序必须一一对应,而且[被复制的数据]必须符合于[操作表]的[约束条件]
--只复制数据,不复制约束条件
create table BuyersList2 --新建一张表
(
	BuyerID2 bigint identity(10001,1) constraint PK_BuyerID2 primary key,
	BuyerName2 nvarchar(200) not null,
	CommodityID2 bigint not null,
	Score2 tinyint,
	BuyDate date null  --多出的也没关系
)
insert into BuyersList2(BuyerName2,CommodityID2,Score2) --可以[所有]也可以[特定],这里就不写[所有]的写法的了
select BuyerName,CommodityID,Score
from BuyersList
go
--[第二种方式]
--向[新建]的,原先不存在的表导入[另一张已存在表]的数据,只能执行一次
--只复制数据,不复制约束条件
select BuyerName,CommodityID,Score
into BuyersList3
from BuyersList
go

select * from BuyersList
select * from BuyersList2
select * from BuyersList3
select * from CommodityList
