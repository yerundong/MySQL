
USE myemployees ;

# select的基础用法

SELECT 'Tom';-- 常量

SELECT 99%2;-- 表达式

SELECT VERSION();-- 函数

SELECT DATABASE();-- 函数

DESC `jobs`;-- 查看表结构

DESCRIBE `jobs`;-- 查看表结构


SELECT * FROM employees; -- 查询所有字段

SELECT `last_name`,`first_name` FROM `employees`;-- 查字段


SELECT `salary`*12 AS '年薪' FROM `employees`;

SELECT TOP 10 `department_id` FROM `employees`;


SELECT `last_name` AS '姓',`first_name` AS '名' FROM `employees`;-- 起别名

SELECT `last_name` '姓 氏',`first_name` '名 字' FROM `employees`; -- 省略as

SELECT *, `last_name` AS '姓 氏',`first_name` AS '名 字' FROM `employees`; 


SELECT DISTINCT `department_id` FROM `employees`;-- 查询去重，重复的值去掉





