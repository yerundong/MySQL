/*
	�����������+��-��*��/��%
	��ֵ�������= 
	�߼��������and��or��not ���ȼ���not > and > or
	�Ƚ��������>��<��=��>=��<=��<>��!=(��sql92��׼)
	�����������+
*/

select 7%3 as ȡ����

select 5/2 as ȡ��  --2.5
select 5.0/2 as ȡ�� --2.500000
select 5.00/2 as ȡ�� --2.500000

declare @num int;
set @num = 23;
select @num as ȡ��ֵ

declare @x int,@y int;
set @x = 2;
set @y = 3;
if @x > @y 
	select '@x����@y' as �Ƚϴ�С
else if @x < @y 
	select '@xС��@y' as �Ƚϴ�С	
else 
	select '@x����@y' as �Ƚϴ�С	
	
if(6>5 and 8<10 or not 1>2)
	select 'true' as �߼�����	
else 	
	select 'false' as �߼�����	
	
declare @str1 nvarchar(20),@str2 nchar(2),@num1 bigint,@num2 int;
set @str1 = 'abc��';
set @str2 = '����';
set @num1 = 1;
set @num2 = 2
select @str1 + @str2 as ���ӷ�	
select @str1 + @num1 --���Ͳ�ͬ�������ӣ���Ҫת������