use BCRM
select * from Activity_Plan --查询所有列

--select Theme from Activity_Plan --查询Theme这个列

--select Theme,Kind from Activity_Plan --查询Theme,Kind列

select distinct Theme,Kind from Activity_Plan --返回Theme,Kind都唯一不同的值,多个重复的只返回一个。

select top 10 * from Activity_Plan --返回前10个

--【where用于筛选、过滤记录】
select * from Activity_Plan where ID = 2 --查询ID = 2的列

--【or,and,between...and...】
select Theme,ID from Activity_Plan where ID >=2 and ID <=5 or ID>=28 --AND、OR运算符用于基于一个以上的条件对记录进行过滤。

select Theme,ID from Activity_Plan where ID between 3 and 5 --介于值3<=id<=5之间，值可以是数字、文本、日期、金钱

select Theme,ID from Activity_Plan where ID not between 3 and 5 --不介于3,5之间

--【order by 按照升、降序对记录进行排序】
select * from Activity_Plan order by Month ASC --ASC升序，DESC降序

--【like模糊查询】
select * from Activity_Plan where Theme like '%中秋%'  --查询包含中秋的行，%替代0或多个字符

select * from Activity_Plan where Theme not like '%节%' --查询不包含中秋的行  

--【通配符】
select * from Activity_Plan where Theme like '%节%'  --%替代0或多个字符

select * from Activity_Plan where Theme like '_秋%'  --_替代1个字符

select * from Activity_Plan where Theme like '情人节活动'  --与Theme = '情人节活动'一样

--【in选取特定的值】
select * from Activity_Plan where ID in(1,3,5,6,9,10) 



















