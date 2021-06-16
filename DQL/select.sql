USE myemployees ;

SELECT `last_name`,`first_name` FROM `employees`;-- 字段名

SELECT `last_name` AS '姓',`first_name` AS '名' FROM `employees`;-- 起别名

SELECT `last_name` '姓 氏',`first_name` '名 字' FROM `employees`; -- 省略as

SELECT * FROM employees; -- 查询所有字段

SELECT 'Tom';-- 常量

SELECT 99%2;-- 表达式

SELECT VERSION();-- 函数

SELECT DATABASE();-- 函数

SELECT `department_id` FROM `employees`;-- 查询所有的值

SELECT DISTINCT `department_id` FROM `employees`;-- 去重，重复的值去掉

SELECT TOP 10 `department_id` FROM `employees`;

SELECT * FROM `employees` WHERE `department_id` = 70;

SELECT * FROM `employees` WHERE department_id >= 120;
