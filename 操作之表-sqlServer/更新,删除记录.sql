use MyDB
/*===================更新记录=======================*/
--UPDATE 语句用于更新表中已存在的记录。
--如果省略了WHERE 子句,则更新所有的数据
--无法更新[标识列],更新的数据需要符合该列的[约束条件]
update BuyersList set  BuyerName = '哈恰热恰恰额', Score = default where  BuyerID = 10001 and CommodityID = 1001


/*===================删除记录=======================*/
--[第一种:delete删除]
--删除记录后,标识序号会继续往上增长,并[不会从标识种子开始计数]
delete BuyersList where BuyerID = 10008
--删除记录必须先删除子表中关联的数据,再删除主表中的该记录
delete BuyersList where CommodityID = 1008
delete CommodityList where CommodityID = 1008
/*
insert into BuyersList2
values('qwe',1009,1,'2017-6-9')
*/ 
--[第二种:truncate table 截断删除]
--删除记录后,标识序号[从标识种子开始计数]
--清空表记录,相当于没有where筛选的deleted table
--无法截断存在主键被引用的表,除非它的所有子表都被删除(它的子表清空记录也不行,必须是删除)
drop table BuyersList --先删除子表
--truncate table BuyersList3
truncate table CommodityList

go

--select * from BuyersList

select * from BuyersList3

select * from CommodityList












