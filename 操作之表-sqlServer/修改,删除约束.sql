use MyDB
go
/*=============修改约束==================*/
--主表约束（添加约束必须【先主表后子表】）

alter table PersonInformation with nocheck --with nocheck对表中已存在的数据不做检查
	drop constraint DF_PersonAdress,
		 constraint FK_EventID
	
alter table EventInformation with nocheck
	drop constraint UQ_EventMark 

alter table EventInformation --修改表，添加约束 【语法：约束名 约束类型 】
		add constraint UQ_EventMark2 unique(EventMark)

