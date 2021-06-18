/*
	算数运算符：+、-、*、/、%
	赋值运算符：= 
	逻辑运算符：and、or、not 优先级：not > and > or
	比较运算符：>、<、=、>=、<=、<>、!=(非sql92标准)
	连接运算符：+
*/

select 7%3 as 取余数

select 5/2 as 取商  --2.5
select 5.0/2 as 取商 --2.500000
select 5.00/2 as 取商 --2.500000

declare @num int;
set @num = 23;
select @num as 取赋值

declare @x int,@y int;
set @x = 2;
set @y = 3;
if @x > @y 
	select '@x大于@y' as 比较大小
else if @x < @y 
	select '@x小于@y' as 比较大小	
else 
	select '@x等于@y' as 比较大小	
	
if(6>5 and 8<10 or not 1>2)
	select 'true' as 逻辑运算	
else 	
	select 'false' as 逻辑运算	
	
declare @str1 nvarchar(20),@str2 nchar(2),@num1 bigint,@num2 int;
set @str1 = 'abc嗨';
set @str2 = '哈罗';
set @num1 = 1;
set @num2 = 2
select @str1 + @str2 as 连接符	
select @str1 + @num1 --类型不同不能连接，需要转换类型