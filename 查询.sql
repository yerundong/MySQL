USE myemployees ;

#一般查询
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

SELECT `salary`*12 AS '年薪' FROM `employees`;

DESC `jobs`;-- 查看表结构
DESCRIBE `jobs`;-- 查看表结构


#条件查询

SELECT * FROM `employees` WHERE `department_id` = 70;

SELECT * FROM `employees` WHERE `department_id` != 70;

SELECT * FROM `employees` WHERE `salary` > 10000;

SELECT * FROM `employees` WHERE `salary` >= 10000;

SELECT * FROM `employees` WHERE `salary` < 10000;

SELECT * FROM `employees` WHERE `salary` <= 10000;

SELECT * FROM `employees` WHERE `salary` BETWEEN 9500 AND 10000;

SELECT * FROM `employees` WHERE `salary` BETWEEN 9500 AND 10000 OR `salary` > 20000;

SELECT * FROM `employees` WHERE `salary` <= 10000 AND `salary` >= 9500;

SELECT * FROM `employees` WHERE `salary` < 10000 AND `salary` > 9500;

SELECT * FROM `employees` WHERE `manager_id` IS NULL;

SELECT * FROM `employees` WHERE `commission_pct` IS NOT NULL;

SELECT * FROM `employees` WHERE `salary` = 12000 AND `commission_pct` = 0.3;

SELECT * FROM `employees` WHERE `salary` = 12000 OR `commission_pct` = 0.3;

SELECT * FROM `employees` WHERE (`salary` = 12000 OR `commission_pct` = 0.3) AND `manager_id` = 100;

SELECT * FROM `employees` WHERE `salary` IN (10000,11000,12000);

SELECT * FROM `employees` WHERE `salary` NOT IN (10000,11000,12000) AND `salary` > 8000;

SELECT * FROM `employees` WHERE `first_name` LIKE 'p%';

SELECT * FROM `employees` WHERE `first_name` LIKE '_e%';

SELECT * FROM `employees` WHERE `first_name` LIKE '% %';

SELECT * FROM `employees` WHERE `job_id` LIKE '%\_%';-- 转义


#排序

SELECT * FROM `employees` ORDER BY `first_name` ASC;-- 升序

SELECT * FROM `employees` ORDER BY `first_name`;-- 默认升序

SELECT * FROM `employees` ORDER BY `first_name` DESC;-- 降序

SELECT * FROM `employees` ORDER BY `salary` DESC;-- 工资降序

SELECT * FROM `employees` ORDER BY `salary` DESC, `first_name`;-- 工资降序，名字升序

SELECT * FROM `employees` ORDER BY 2;-- 第二列升序


#条件查询+排序
SELECT * FROM `employees` WHERE salary BETWEEN 9600 AND 12000 ORDER BY first_name;
